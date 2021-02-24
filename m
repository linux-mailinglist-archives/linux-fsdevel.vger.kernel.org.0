Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937A13237C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 08:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhBXHQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 02:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhBXHQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:16:09 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC3C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 23:15:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so973295ior.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 23:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8mnisfsMQh7DWxYjGik5XwdXMgnMbISx4g2kSATFAw=;
        b=f/1kPVJnrI4/oMXaLiD3A9nqwIOpFApFhCZdcN2wxDzkw8HEzjDoLmkzx8XgFnV9js
         0YMN0pgoymTdqi5YRZlfYZwF3TKw3UV13lyF4joleJDOfO4NQ0fYS0FVAY2+2aMURosv
         OYP5DuidoVYSZtae/Q4mLebQqJbXXje92qEC/QmoH89pKqEV3AkyCILpnVAxTVd/7M2E
         cQ6iczyLDhbfOc2hJtFB9dceJIbUC5gzKbn1SoCb7L5bH8+RobwPC8Abgn3/oBPIGksW
         1/BSCkkbYvCysPP41YneVVmZhEkxDAvYxu7banvcSt1WfDKVgY4DWa7LBdx91InG9gk/
         OB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8mnisfsMQh7DWxYjGik5XwdXMgnMbISx4g2kSATFAw=;
        b=mwBP7Ve/r8TTQ6c4VEm3ULtf/PfaaPult8YDVAbQOgCt+PyKlCMIV8CT/dGZS9+xkS
         4cGZwBD5foaPSfBNz0Ty/Tk69gUf49KETKf+UUxSamzaHLro9M1cCPXHEXFSkIralHQ1
         VvWmZSB98D/6d7SCRR+HNes4KghKJnm7F6tmQoQD+VshxKSYvASFSKXAtl6SN1qMg628
         8yRh4Mcr2x/XQUMe8+MMYTEtJw2RqfuEHwqII5FpZh7Vt0pAF+M0oOjnVJVm662OYF3h
         r8m//rl2nsggcQOJuA2lj6e2QEWaD5CBQL6WTh0tdx0ncx+AkfFov1ALcwyolReqx+Wi
         x3Yw==
X-Gm-Message-State: AOAM532L7YYpYDWCPpFg8hU84SZPVfe5n1Mu4vqDgUhvnTWmIvSSCU6f
        obNmQEpJkE/WHg5j4orC1T6/zy1huO/7cV0k5yg=
X-Google-Smtp-Source: ABdhPJyF/smOB5Kba0djNj0xm/T8TE1j37Mud8M6KlacMU6jZr8rYUPvo66h860R47oVQnWzg/kASxLu8CyjwZ0tTlA=
X-Received: by 2002:a02:bb16:: with SMTP id y22mr31477148jan.123.1614150929172;
 Tue, 23 Feb 2021 23:15:29 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjGkm0Pn84UW6JKSK3mFkrPKykfkXDLL1V4YPSgAOXULA@mail.gmail.com>
 <20210218143635.24916-1-lhenriques@suse.de>
In-Reply-To: <20210218143635.24916-1-lhenriques@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Feb 2021 09:15:18 +0200
Message-ID: <CAOQ4uxjtap0jQat19h7g+6xvpMnqrwEihgN7pw11d57kkRVsaw@mail.gmail.com>
Subject: Re: [PATCH v4] vfs: fix copy_file_range regression in cross-fs copies
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Luis Henriques <lhenriques@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 4:35 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> A regression has been reported by Nicolas Boichat, found while using the
> copy_file_range syscall to copy a tracefs file.  Before commit
> 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> kernel would return -EXDEV to userspace when trying to copy a file across
> different filesystems.  After this commit, the syscall doesn't fail anymore
> and instead returns zero (zero bytes copied), as this file's content is
> generated on-the-fly and thus reports a size of zero.
>
> This patch restores some cross-filesystem copy restrictions that existed
> prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> devices").  Filesystems are still allowed to fall-back to the VFS
> generic_copy_file_range() implementation, but that has now to be done
> explicitly.
>

Petr,

Please note that the check for verify_cross_fs_copy_support() in LTP
tests can no longer be used to determine if copy_file_range() is post v5.3.
You will need to fix the tests to expect cross-fs failures (this change of
behavior is supposed to be backported to stable kernels as well).

I guess the copy_file_range() tests will need to use min_kver.

Thanks,
Amir.
