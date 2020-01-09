Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F01352CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 06:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgAIFpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 00:45:20 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:32965 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgAIFpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:45:20 -0500
Received: by mail-pg1-f178.google.com with SMTP id 6so2674991pgk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 21:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:mime-version:content-id:date:message-id;
        bh=lcX+bMkzZdNuKee9UFHwA6yraMbsvHhMh1TYkr3y65U=;
        b=LVA9oTnqSf77kMGcOaCgxrIHnMrSFijLlUxxIuThln7t/yNGehQfNWAB5KU690Ypf7
         EwK5sKtWnE5XxS/s+Bc4cAdAnW3J9IbuoR+Il4E0wqRrhA57b2YEZdaAslmlowkvWWgT
         uVyoDEBG7VzsNs+IDIY8YWx3d0B+C6zy32xaGULB/Y4q4wsNLA/pXT5xM/z9BsfocRwd
         xC216pKCXx+TpKXP3LCsf4cvHoDV8FCYi2B2NBILzpIJ0XejY3mm5+6CS6IxbgFy61Kl
         9rcBD6n1IRiEqt5hRMe4R1u2uFl2QvIn84x1xVu+h8UFVoSSIND7ubmVHA3V4IHhCtgG
         g5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:content-id:date
         :message-id;
        bh=lcX+bMkzZdNuKee9UFHwA6yraMbsvHhMh1TYkr3y65U=;
        b=b3McsQOvesEaqogU/KLhBwsNE/khkZQ2Sdw2bL7akm/xp2SjvpOh/ozprCLX+RT917
         0e/VF866k3IY8j5g5RLNpWDvhDAs9vZigTcN22+jiqHJ1Q6smMbFGwnDf6Ya/YU95j5y
         dvUu/0AUouq+X5kFnWsmWrlYikij0DOUxqXOIxMT/YeENxwqOG8SzrEoDItgaIzP4Oer
         XMxcRyys9I0aHiTIR5NjBwO5OFVdf6rl5Lb8t3OirfK926pwDgO7tBGwJfnoVLTE9GuE
         mfLCX4JNPFzPFYZSqTR5UOybSIJ48oTEEIi3u0IPN/TIG54wcYy8ktJP8h8/hR+7t3mU
         iiFA==
X-Gm-Message-State: APjAAAV41EDhSUruzSWLW/gotQB9cBDsFIEO1xlhzAP6NOKo7czfLDM9
        gIGMRaHGMHcEU60ijT+RQAs=
X-Google-Smtp-Source: APXvYqx0Ft/F0XtbAWcQMlKtO+itz37aoDGlXAj12AsZJxRRPje1jyIgB6WtciTIyeDn23HC7YfZyA==
X-Received: by 2002:aa7:949a:: with SMTP id z26mr9245233pfk.98.1578548719393;
        Wed, 08 Jan 2020 21:45:19 -0800 (PST)
Received: from jromail.nowhere (h219-110-240-103.catv02.itscom.jp. [219.110.240.103])
        by smtp.gmail.com with ESMTPSA id r7sm5900899pfg.34.2020.01.08.21.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 21:45:19 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1ipQdA-0004Qw-UF ; Thu, 09 Jan 2020 14:45:16 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: Q, SIGIO on pipe
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17044.1578548716.1@jrobl>
Date:   Thu, 09 Jan 2020 14:45:16 +0900
Message-ID: <17045.1578548716@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Between v5.4 and v5.5-rc5, big changes are made around pipe and my test
program behaves differently.

{
	err = mknod(fname, S_IFIFO | 0644, /*dev*/0);
	fd = open(fname, O_RDWR, /*mode*/0);
	err = sigaction(SIGIO, &sa, NULL);

	pid = getpid();
	err = fcntl(fd, F_SETOWN, pid);
	err = fcntl(fd, F_SETSIG, SIGIO);
	flags = fcntl(fd, F_GETFL);
	err = fcntl(fd, F_SETFL, O_NONBLOCK | O_ASYNC | flags);

	ssz = write(fd, &i, 1);
	ssz = read(fd, &i, 1);
}

In v5.4, the final write(2) and read(2) generate/send SIGIO for each,
POLLIN and POLLOUT respectively.
But in v5.5-rc5, read(2) doesn't generate/send SIGIO POLLOUT while it
reads 1 byte successfully.

Reading new pipe.c, pipe_read() fires the signal only when the pipe
buffer was full (16 as PIPE_DEF_BUFFERS defines), so my test program
which writes only 1 byte doesn't receive the signal.  Am I right?  If
so, is this an intentional behaviour and the previous behaviour was
wrong and violated some standards?


J. R. Okajima
