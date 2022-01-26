Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D644349CD37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiAZPCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 10:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbiAZPCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:02:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBFC06161C;
        Wed, 26 Jan 2022 07:02:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id o12so39641082eju.13;
        Wed, 26 Jan 2022 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=1l8OLoo8JH3VOdfiA7Nj8EQHR5qIBs6PmIsbZa+6ZwI=;
        b=gbbDtcSZKlnvq1FVSQMFn3XJHItSGXQeRKE0XtiS5tJGKoO92dWmROcu7AJEQ7rHqu
         YcOBaoEaS7HfiuepXpFASBi0eLn/YsRTa/XguoyAiO/ocgypiH7Fr+knTCuI+JFaRWP0
         tKJkutnKPpsy7zjki7B9wtz0WqSGuCW87S2tb9YflOiMCyRFcXM8pHc+5Qridst/No1a
         BZ3+8EZZ60d8N616J1guuvBjicr8D2z6uTr3pUPynntitGOsOG66aX6SPKybT98uy4eJ
         edhoXD52FumWr68D2gBFDSvNaQwCJ+J4b5t1q/P/b/e/wTIcRFIOwtcMD+8++U4gEksc
         ZjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=1l8OLoo8JH3VOdfiA7Nj8EQHR5qIBs6PmIsbZa+6ZwI=;
        b=3zaem/D0pjOD0fvKdIXmzHxIVEZLB679O/5l/ExrBCcH9gxOE37jZMeCuG+3fHmHWd
         41U7kcRHUF1jHxVkMP5BWp9UW5huQwL2JkmFWUmHqBUknacSwVZuM3BgV8yQcukka6PG
         eQHHu36PJafFYnSA+MoihyOWBwVq6pP0kPWH8yA5yjJZ+1k2ZZtH80FpmX1a7OdMOB40
         VTOib95ybSN/GsfvKJUcZbPLVA5QOl4mfTTJ6Hh/KJNu1ZCMUEgNJ34iLgpwnVCf0yQ0
         21CvXzpvUsUXnodUtOq+2Ax6M82dQdOn4oNqby5hAE1snFfCHs6wKKvuHf4+66o78Lsk
         iXhQ==
X-Gm-Message-State: AOAM533E6ld3CnvOL065DqdkXTr5a1iT0qWzmSgUmSRWnhD8b7AmfcOs
        2H8e2GHv/tvs4utYUTCwLw==
X-Google-Smtp-Source: ABdhPJylxrJg6hRIpU/8KlRd5dP2560K/Y88X1q2ggCTs9balxdDRm3gdncCoxdjEzdpMp6QQK0LLg==
X-Received: by 2002:a17:906:1c4e:: with SMTP id l14mr20706695ejg.480.1643209348792;
        Wed, 26 Jan 2022 07:02:28 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.73])
        by smtp.gmail.com with ESMTPSA id g4sm9960396edl.50.2022.01.26.07.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:02:28 -0800 (PST)
Date:   Wed, 26 Jan 2022 18:02:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     ariadne@dereferenced.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Message-ID: <YfFigbwhImLQqQsQ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>	execve("...", NULL, NULL);

I personally wrote a program which relies on execve(NULL) to succeed.
It wasn't an exploit, it was test program against IMA-like kernel
"only whitelisted executables can run" feature.

Test copies and "corrupts" itself by appending \0 to the end, then tries
to reexec itself with execve("/proc/self/exe", NULL, NULL);
main() if run with argc==0 exits with specific error code.

Appending \0 breaks checksum so working kernel protection scheme must
not allow it, therefore if execve(NULL) succeeded, than the parent
process doing test hard fails.

Also appending \0 doesn't break ELF structure. In other words,
if executable A is working (and it is working because it is running)
then A||\0 is valid executable as well and will run too.

This is independent from filesystem layout, libc, kernel, dynamic
libraries, compile options and what not.

Now QNX doesn't allow execve(NULL) and I don't remember if I changed it
to the next simplest variant and I don't work anymore at that company,
so I can't check :^)

	execve("/proc/self/exe", (char*[]){"Alexey", NULL}, NULL);

P.S.:

	> tptacek 5 minutes ago | root | parent | next [–]
	> There is not.

	Yes, there is!
