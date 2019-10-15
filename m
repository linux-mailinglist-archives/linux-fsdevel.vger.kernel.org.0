Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F5D83B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbfJOWcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 18:32:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37230 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbfJOWcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:32:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so15754097lff.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=SIEI+eyzsLvgKQSWy68fNU4waAO3JnvS6nzHr5/fZu5+F3lS+ninFSB5dUKCVryHZ+
         kl8H8QJRcmYfRoBpcYQdlcvyFYmbnE5AhMRuYRji7sgqsBgEDlqfBvGU7GUQWJu2UMf7
         6W/csLC8ZHTI+HN72RKiuRYhkxOOMexsvDhzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=JGJRhvby9n/ykaEUqFp6+ZPJ2ii8BySlGvvmN2u+G5b29iwQHh2nZbefMVZ5YOe5Tx
         asmCIj2lqn6l198EogJigcqTLB44UtH0HAW0YAUdQWiO77D+eFkao6tP42jYVbzaCllv
         q1r26a5/R4HSZR/iqhHDuMMsKp/VLg2U9VReoODKMoNV7dDRed63aBwAEeJcil9wBKt/
         mDPf65j+68r9yTzO2LrUjym15/dYlXhE+5vOBLx0aT3P1GGhU10asoOpGQbbCDTIQc3Y
         exDMGjDh2i6xvNK4BDkRZMo8a+HxJpjldECl4AsftNU43FwDpa/3QKZk/J9+3sthfpzb
         oq1w==
X-Gm-Message-State: APjAAAWcjOCDIiksMIckMsXsKx925S3qbjffCnjLJfu0YoZX1DtJStm+
        77uGUUOJUiVNYYlXN62CuFddEioud/k=
X-Google-Smtp-Source: APXvYqzAFtCTe6qiQd9lc7+tVZoXrGQVsOQH8WHKOqp2aWrl69wMxT59f32Ca+ums0xy6OKg//Wykg==
X-Received: by 2002:a19:5e53:: with SMTP id z19mr3034568lfi.111.1571178748566;
        Tue, 15 Oct 2019 15:32:28 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g10sm5402471lfb.76.2019.10.15.15.32.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:32:25 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 195so2792991lfj.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr4230778lfe.106.1571178744104;
 Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:32:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] pipe: Keyrings, Block and USB notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aside from the two small comments, the pipe side looked reasonable,
but I stopped looking when the patches moved on to the notificaiton
part, and maybe I missed something in the earlier ones too.

Which does bring me to the meat of this email: can we please keep the
pipe cleanups and prepwork (and benchmarking) as a separate patch
series? I'd like that to be done separately from the notification
code, since it's re-organization and cleanup - while the eventual goal
is to be able to add messages to the pipe atomically, I think the
series makes sense (and should make sense) on its own.

          Linus
