Return-Path: <linux-fsdevel+bounces-31273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3A993E02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 06:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49921C242D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 04:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744113541B;
	Tue,  8 Oct 2024 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dLECnaOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E83C0C;
	Tue,  8 Oct 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361675; cv=none; b=KKVRPDeh714jSi4+OzwGLChIfAlOEB6WdQ3FUsqbfTL5T5V6keJAsPoZb22PhmReVi+AP8ozKFJQ5dJSrdY74IZodAVrI6xuMVVaVNj44cFuU4/m6wTD+uHmiJkTU79Io2v9U0/LrrNdSF1mqSnrWn/bpb7WAvW/AnHzgQ76GXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361675; c=relaxed/simple;
	bh=6gBTO/OpHWI/g1Knzunppq+qTTQF+P7o9kRR68ZQvjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=filduuUJjVZ3zOJSHFpzkcr1BFfqmQUyUBW/GYKHrNyoHUpsJaknam1AEA2UFkO/IzSXyZBMeIrNNMX4bNurXnu0WwQOC23zGf1e+IQp1sMdXwFa2ekFUH2p6E3fwaNogeKXbtRiYwgDpezfEIt2US7dXoegVuopG5kYl4yhxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dLECnaOS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WFgCWbl+XbvVY/hGhjp0glK6RLCXbWZiKcTPW6ZP8jk=; b=dLECnaOSG9GYFL+vv0CeHEn8bC
	Sg7GhV4x+mM19h7Sm9whO5awZrn0cpQQPVKK19N0s+8+Umeg1MUSJS9N9ZpEKf2m3skbx7yYFoOpR
	tU80JRVOGyBbO0bfimdgsotm7Va3JKuoXlYqUoyNgMzyMoRHVAkMbZYZuAUEmm3Jn4hL1KuoDmsJs
	4RyrFAkSNASV22AO9pQdhP1oVSR1bv3aw5DUVJJdsjrfZuEUxRqK9tV0hfXE1qhkzOLLypJJgAmFE
	NF+snte0gMz75Ikx2OgThwwQaTibU+2PZ1ghBIYaQT1Pbwae6BnxFvS1mzYKl3YslRSOVr9OX/Ais
	XNVmwwLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy1p9-00000001li6-1UCp;
	Tue, 08 Oct 2024 04:27:51 +0000
Date: Tue, 8 Oct 2024 05:27:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>,
	Miao Wang <shankerwangmiao@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: Make sure {statx,fstatat}(..., AT_EMPTY_PATH |
 ..., NULL, ...) behave as (..., AT_EMPTY_PATH | ..., "", ...)
Message-ID: <20241008042751.GW4017910@ZenIV>
References: <20241007130825.10326-1-xry111@xry111.site>
 <20241007130825.10326-3-xry111@xry111.site>
 <CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com>
 <20241008041621.GV4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008041621.GV4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 08, 2024 at 05:16:21AM +0100, Al Viro wrote:

> Folks, please don't go there.  Really.  IMO vfs_empty_path() is a wrong API
> in the first place.  Too low-level and racy as well.
> 
> 	See the approach in #work.xattr; I'm going to lift that into fs/namei.c
> (well, the slow path - everything after "if path is NULL, we are done") and
> yes, fs/stat.c users get handled better that way.

FWIW, the intermediate (just after that commit) state of those functions is

int vfs_fstatat(int dfd, const char __user *filename,
                              struct kstat *stat, int flags)
{
        int ret;
        int statx_flags = flags | AT_NO_AUTOMOUNT;
        struct filename *name = getname_maybe_null(filename, flags);

        if (!name)
                return vfs_fstat(dfd, stat);

        ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
        putname(name); 

        return ret;  
}

and

SYSCALL_DEFINE5(statx,
                int, dfd, const char __user *, filename, unsigned, flags,
                unsigned int, mask,
                struct statx __user *, buffer)
{
        int ret;
        unsigned lflags;
        struct filename *name = getname_maybe_null(filename, flags);

        /*
         * Short-circuit handling of NULL and "" paths.
         *
         * For a NULL path we require and accept only the AT_EMPTY_PATH flag
         * (possibly |'d with AT_STATX flags).
         *
         * However, glibc on 32-bit architectures implements fstatat as statx
         * with the "" pathname and AT_NO_AUTOMOUNT | AT_EMPTY_PATH flags.
         * Supporting this results in the uglification below.
         */
        lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
        if (!name)
                return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);

        ret = do_statx(dfd, name, flags, mask, buffer);
        putname(name);

        return ret;
}

static inline struct filename *getname_maybe_null(const char __user *name, int flags)
{
        if (!(flags & AT_EMPTY_PATH))
                return getname(name);

        if (!name)
                return NULL;
        return __getname_maybe_null(name);
}

struct filename *__getname_maybe_null(const char __user *pathname)
{
        struct filename *name;
        char c;

        /* try to save on allocations; loss on um, though */
        if (get_user(c, pathname))
                return ERR_PTR(-EFAULT);
        if (!c)
                return NULL;

        name = getname_flags(pathname, LOOKUP_EMPTY);
        if (!IS_ERR(name) && !(name->name[0])) {
                putname(name);
                name = NULL;
        }
        return name;   
}

