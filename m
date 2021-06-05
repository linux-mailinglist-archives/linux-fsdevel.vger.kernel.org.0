Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9F39C9B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFEQHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 12:07:32 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:41972 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEQHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 12:07:32 -0400
Received: by mail-pj1-f51.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso7663384pji.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jun 2021 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:mime-version:content-id:date:message-id;
        bh=mWsrTGi+fe7qSnEYid59BqQoaUKRggrM3JLEBr799bE=;
        b=Yr1CslXmwHgefCHkc7bFnOOO6/vqmbrLQt2TkoofDL0hQcM0aBUdlrJwb4kDgryv79
         6AVz5P8TPYsZ0vAsBPBInuduVQQJUFHeeTFPZf/x6DnU31ZG7UdW6L6fW9aQh7tfOJH5
         LlbUrnoXleKdb656wBo5Oex2fTE4oc2cWIld0AFTctk4tu7njJlmoWVnkQix7xJFFt5/
         040VyVsM80p9CPUbFdoa36QAgacaKG2v5I8XGoe+D5YAHbwzLkYNYjkLkL2rVYFpKyDM
         MYSttHABgaw4er4FmJ1aX255GKvzk78/SN9KIUCnoP3kxsqt5pcAQkFlV/T5j1OwXkO9
         hUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:content-id:date
         :message-id;
        bh=mWsrTGi+fe7qSnEYid59BqQoaUKRggrM3JLEBr799bE=;
        b=R+IsNLgRelVzcwUwbFXv3/tv/XwiEoXOKKb7s2yuvNkQ2VsThpXd7pQPJE/5q6+47z
         SGJK7i2HKlCPbEefqlx8jnz6kzgEqpbOM9Ehjd6kB4VA6unoT/5NaTM2ypAv72StDkp2
         qSk2BQq2qQC0yXOXhfhZWw7XalWE09d5XXX/3h6rGIAqs454FiHF3pG0i5Z8AiHxRPbP
         s3h71SWX9z+DsRvETYGQhICfBqM42/XIlg+Hg+06xhb0+oj6VCka9y5BUoEK7VhPp6y+
         Rc6cqJEEA7TIpMGR7qMWzDC1xRv+nm/Jsp5Fj2F5rnrbHoSIrVCxV3UxDlhFa6ogmSZB
         z5nA==
X-Gm-Message-State: AOAM533BbCpLmRuSu+KG/+azQjIAl2UF3W5tnSR+7wm1VYN0MnmzC5GA
        iULJ+wkywQoPlAioZAciMc0=
X-Google-Smtp-Source: ABdhPJxrSdzQMwW/Fd7MooyG1dy9+acHEvEgHqVr2cjg+dEKzfiL48TPPS9BIPnwTCH5VcTtUvQMmA==
X-Received: by 2002:a17:90a:bb06:: with SMTP id u6mr10702231pjr.201.1622909073784;
        Sat, 05 Jun 2021 09:04:33 -0700 (PDT)
Received: from jrobl (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id q24sm4821104pgk.32.2021.06.05.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 09:04:33 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1lpYml-0000Na-V9 ; Sun, 06 Jun 2021 01:04:31 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: fanotify: FAN_OPEN_EXEC_PERM stops invoking the commands
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1460.1622909071.1@jrobl>
Date:   Sun, 06 Jun 2021 01:04:31 +0900
Message-ID: <1461.1622909071@jrobl>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

fanotify has a neat feature called "perm event" which makes the listener
process can allow/deny the access to a file by another process.
But it doesn't work well if
- FAN_OPEN_EXEC_PERM event is monitored
- the other process's executable is monitored by the listener process

The scenario is like this.
- fanotify_init(O_RDWR)
- fanotify_mark(FAN_OPEN_EXEC_PERM, "/dirA")
- read() the event via fanotify_fd. it blocks.
and run "/dirA/a.out" executable on another terminal.

Then
- FAN_OPEN_EXEC_PERM event is enqueued
- the listener process tries reading the event
- fanotify tries preparing FD by opening the executable. the flag to
  open is the one given to fanotify_init(). it is O_RDWR here.
- we cannot open the running executable with O_RDWR flag.
- fanotify forces FAN_DENY as a response to the perm event.
- the listener read() gets ETXTBSY from fanotify.

As a result,
- the listener process cannot get the perm event, and cannot write
  the response FAN_ALLOW either.
- a.out process fails to start (EPERM) because fanotify sets FAN_DENY.

In other words, fanotify stops invoking a.out even if the listener
process wants to allow it.
That is bad.

My question is,
Why do we need to reuse full fsnotify_group->fanotify_data.f_flags when
opening the executable?  I can understand people may want to set
O_NONBLOCK or O_CLOEXEC flags.  But how about RW flags?  Isn't it good
enough to force opening fanotify_event_metadata.fd with O_RDONLY?
Passing O_RDWR to fanotify_init() should be kept in order to make
fanotify_fd writable.


J. R. Okajima
