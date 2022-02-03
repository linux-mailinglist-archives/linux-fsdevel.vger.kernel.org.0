Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46DE4A7EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 05:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiBCE3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 23:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiBCE3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 23:29:49 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080FFC061714;
        Wed,  2 Feb 2022 20:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Cc:To:From:Date;
        bh=fYvOccN6LpzCBObzlIWTwUECGI8Ejo6f/Qj5vmeOtbI=; b=agoVOzTD9SDHCLO2LgCXFClslJ
        NohcjFYXkjLwPrGt3joQdHwK6KaL/iU7C3tv1020VG47qjiFwrqqIR7TmrPNwI3C+Lgc+LgwHYgMe
        S2JDxbfxR9Cr/AynvfButWv8UM4qP6LM+gcZCRTpm5AUNvkCXKYpHjGkjvS7d/l1QRrBVeZZs7IQj
        5QyezCnstm2Y9NkS3dEswvGC79ZCnUeKhG8EaUATl2xrbkDffO0Y7uxFsrMBky+vz2nzo7fS91M77
        30bCi7JLWL0XVHM96sqPYCG8zMt4TqdKNiVEgHyeLTuy23pHSCBjxTF+etq5fMjXQW7hb2q5TpK1u
        tbZq5Uh67q3iZWJVIBW2hJug7uTragu5TjuXwyVxzy3LHFuKVCzUiNXAvvA6FBw3Sz2aYeLj9flss
        b9517jxahAWxA4stPvG2RjKSh0mfDxrTQAu5SqyJmWgdvjtaRjCbapHPwI10fCafEJqeggibc/lhU
        VAN3M006/6jPWdeQO+b39VOx;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1nFTkf-001v9s-S4; Thu, 03 Feb 2022 04:29:46 +0000
Date:   Wed, 2 Feb 2022 20:29:42 -0800
From:   Jeremy Allison <jra@samba.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [ksmbd] racy uses of ->d_parent and ->d_name
Message-ID: <YftaNrtziHd88b1j@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <YfdCElWBOdOnsH5b@zeniv-ca.linux.org.uk>
 <CAKYAXd-k=AvMcxsJg1rVsY2PPhsZuRUegqAhEFB2r-qXH3+5-w@mail.gmail.com>
 <YftT5X0s6s5b8DiL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YftT5X0s6s5b8DiL@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 04:02:45AM +0000, Al Viro wrote:
>On Thu, Feb 03, 2022 at 08:16:21AM +0900, Namjae Jeon wrote:
>
>> > 	Why is so much tied to "open, then figure out where it is" model?
>> > Is it a legacy of userland implementation, or a network fs protocol that
>> > manages to outsuck NFS, or...?
>> It need to use absolute based path given from request.
>
>Er... yes?  Normal syscalls also have to be able to deal with pathnames;
>the sane way for e.g. unlink() is to traverse everything except the last
>component, then do inode_lock() on the directory you've arrived at, do
>lookup for the final component and do the operation.
>
>What we do not attempt is "walk the entire path, then try to lock the
>parent of whatever we'd arrived at, then do operation".  Otherwise
>we'd have the same kind of headache in all directory-manipulating
>syscalls...
>
>What's the problem with doing the same thing here?  Lack of convenient
>exported helpers for some of those?  Then let's sort _that_ out...
>If there's something else, I'd like to know what exactly it is.

Samba recently did a complete VFS rewrite to remove almost
*all* pathname-based calls for exactly this reason (remove
all possibility of symlink races).

https://www.samba.org/samba/security/CVE-2021-20316.html

Is this essentially the same bug affecting ksmbd here ?

If so, the pathname processing will need to be re-worked
in the same way we had to do for Samba.
