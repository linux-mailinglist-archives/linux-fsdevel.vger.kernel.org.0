Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367BB611AE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 21:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJ1TdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 15:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJ1TdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:33:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00E23B697;
        Fri, 28 Oct 2022 12:33:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f193so5708645pgc.0;
        Fri, 28 Oct 2022 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdrVSt4RZJ3wSeFHE+CjtlpVwqOByBQJYEcfbYTn/5I=;
        b=ggs47vXUkGHFQLomn7C70DyQXIEFvwGH9xKcYgIMKHlAKhAy64oNy5kKNaWBHnyIEr
         y80tz6HBa72CsqWXXm8Zf0yAJ7V2jTjuruF0grcL50Qc1iP0u8DjwumD63ik+KaZa5rB
         MXK9lLI5Pbusqx++TYNX8yNP/C7CKeEjhAqfOqLtjwKX9PIYauNQ5YI3CrocMo+AM6U5
         aupa1Ai+4aG9jX/HPeOq5kru/qUTgws24MWU+F0tW/f1qiaOZVQiUC41vV1nCMzLUoK+
         Y0y2CkZp+jXcfaFFmKKOWc4IW21WrVv5DwE5eURB3SBcT+BFoYcjn491uulp35ZvbCyW
         p5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdrVSt4RZJ3wSeFHE+CjtlpVwqOByBQJYEcfbYTn/5I=;
        b=i9fiDAxtBEuHWjcwX439jIZiAmkWQaPhtZG2GCZpyW7KaKiMyz3AGzN1PSieaR4i0b
         bGE69F8fNn39HrvNluLybwZvFOY11VFDg2hN5kxxni6CQULgQw88Pw2lPOvzcB82c9yh
         QCt3eojF8BdDwjBgYPmmwq8pnbL6/xV8Ht79v7iDzGZF6Mu9pVV1I0TDIF+NV/Oysln1
         vecT1hPArSoevEL/iOxYBKtQMuUg1cPYqBmsnMU+RlOY3vkYG0mRwi8/ImgiA2EyE8Zk
         kZ3mQPevaG2IgM67RD33s4Uec8QVUSPEPjJLAKm3z9u6+JPFVuYMwqc1wsMd5I3ncHeu
         60bQ==
X-Gm-Message-State: ACrzQf1LC/fwVRb66l0Yfnrsk+9J2KCkUPIwq4VoVxNx9my5lBsq6fWA
        qf488l70JiThfk7lvifQ4Rhi0sPOv7SWGP9hxILI/J2j
X-Google-Smtp-Source: AMsMyM4Qw+lrCF+1vQw8UPSvH+5kALby1aCBhATUgK1FnqnC+vUxcg5vZD9r5SRnjxXDcQMcDzalQU29YlHpprTEKEE=
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d52 with SMTP id
 l4-20020a056a0016c400b0053508900d52mr718104pfc.9.1666985589367; Fri, 28 Oct
 2022 12:33:09 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Norden <norden.jeff@gmail.com>
Date:   Fri, 28 Oct 2022 14:32:43 -0500
Message-ID: <CAPbFCnkLy21LRKCEo-HH4VOYe2TUpGezYP4CmYmCE5jbKZ5cOg@mail.gmail.com>
Subject: Subject: magic symbolic links and CAP_DAC_READ_SEARCH
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm certainly no expert, so there could easily be some security issues that
I'm not seeing right now, but...

It seems to me that the CAP_DAC_READ_SEARCH capability ought to allow
readlink() to succeed on a "magic symlink" even when the uid/gid would
otherwise disallow it.

The capabilities(7) man page says:
 CAP_DAC_READ_SEARCH
  * Bypass file read permission checks and directory read and execute
    permission checks;
etc.

This could be handy to see what files a process has open without using
full-blown root priv.  E.g., "ls -l /proc/nnnn/fd/"  run via setpriv or
capsh.

Thanks for listening,
-Jeff

---------
The following illustrates the current situation.  'rsudo' is a personal script
I use to run a command with dac_read_search; sort of a 'read only' version of
sudo. (I really should clean it up a bit and post it somewhere.)

jeff@ups:~$ ls -l /proc/1/fd/0
ls: cannot access '/proc/1/fd/0': Permission denied

jeff@ups:~$ sudo ls -l /proc/1/fd/0
lrwx------ 1 root root 64 Oct 23 13:48 /proc/1/fd/0 -> /dev/null

jeff@ups:~$ sudo readlink /proc/1/fd/0
/dev/null


jeff@ups:~$ rsudo ls -l /proc/1/fd/0
ls: cannot read symbolic link '/proc/1/fd/0': Permission denied
lrwx------ 1 root root 64 Oct 23 13:48 /proc/1/fd/0

jeff@ups:~$ rsudo readlink /proc/1/fd/0

The first 'rsudo' above ran the cmd:
 sudo setpriv --inh-caps +dac_read_search --ambient-caps +dac_read_search
 --reuid=1000 --regid=1000 --init-groups -- ls -l /proc/1/fd/0
The second did the same for 'readlink /proc/1/fd/0'
