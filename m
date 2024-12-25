Return-Path: <linux-fsdevel+bounces-38120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA3E9FC5F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 16:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A47016366F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689B198E8C;
	Wed, 25 Dec 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6LRQ6A5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710792581;
	Wed, 25 Dec 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735141489; cv=none; b=JSeDTMMWrD2Vc65dLFV4BmC49x9nc6hZTSyimz0Xp/qG7Pk4CsRer/BNxaXsueIMF72Y/c1i+/XuP/HWXw5iljjMcUhM3Kuz1rzKcGi15yYWS8i7e++gjkNDg+t7a4yGBAQ0lg3K26SFaJvMdya2i8dYMxXgrXime0/403tRQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735141489; c=relaxed/simple;
	bh=fU/AREz+s5wjQcYbFswILmuRUG4JP5Dr9ZIVGYJ4zEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIgZVTOhWrGHwLrdQFv42Jiz5rDctQDiaVh2nYxl+QZJsXfWRKUexdEOksQJ1Qp+FgtIqJPDMMC/Qv5WvIH3ZIsaDpZMkzXaAHTcDSMuITawih6lWR8owu+/14g5234fksvsRvu/t7x9IqA7apX8OQxNRQ0i5AQ2Mj4K0ywlfc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6LRQ6A5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa67333f7d2so881834266b.0;
        Wed, 25 Dec 2024 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735141486; x=1735746286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+53UwzEqbUdtGlmvmhW3HSSqcAI3HctT/sK7b7zQ2U=;
        b=V6LRQ6A53kWmtj2ULM4uWkl4oyrIaaVTdutm76uoD9ONFOOYu/JYkikEQeLtuNfdLK
         w3PF6BfHMabnfsMsohQr2JhWhwVHCxOA2F600ltsn7J6K4PdlQXA1id6GYp753CFgIlf
         gmBo6/4LTqL004m80jjbaenRrXh1GeaQDNxEa3xBushNBK6yRKNdzTA/I+DDT5Ko31F1
         U3ch7SkvhQBQmpM3fRoNNH18h6SySf2UsSh9sh/esX0b9f+4639qNK7Rkfn1J7/q7iqg
         gVZxbvfzLAzBMVQSPSliNu08K6AUS0nXNm5jqqHucc+DEjzeSkl3vFoDVLxYFTzAehgT
         W/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735141486; x=1735746286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+53UwzEqbUdtGlmvmhW3HSSqcAI3HctT/sK7b7zQ2U=;
        b=stOtZ7qUpLzwY03fyaqk+JwzVzC6wz6AD2Lo8SCHPlmQ6CvNiCRrr0s2MFI1jIIvcQ
         dkwuvsanhGRGTdmVtdIYlsotlbIw2rj1EJte6fe999vH5ZLoQiBgCNYyLvAMGpA8Zpbh
         GNSRXtVwDKbwLfcIs8Je6P7aOgdLwvdNT/JClv5KieiMYZxYbHd35nlc94gsD7CHZ9GR
         VW7f5zzTDNRVYrCz5WhEZ+r5A8jEAECjFO6LgRqAxptn3I3Cy8tpvNHK+3k+7iWJM5Tl
         vGJ6+hX1YBZGf4Y0gM+11SXBTB4p2TUsSPa9Hi84tQSrbLeVGlaD2N2iqhAQ6fi7TDmS
         DAgA==
X-Forwarded-Encrypted: i=1; AJvYcCVd+7qUHapHfZ2V69HHsuBpqZH2YaW1LDbi5JMKDEWbl6EEsRhCDS0BYvTfEUEg1g7TI5O1ufi9kmxM@vger.kernel.org, AJvYcCXEeKCLsSTKoOS/EgPHInp1rbiElo7KmCT82jWMRjA+DRdbl2nzO8ZZkX4Brb//mWnQU4q1Q8SAjl6T3Ejl@vger.kernel.org, AJvYcCXXdn3HvZFa5U4Y6SP1zCKPJ4sf97ZHX6IUIhLyYBeSol9D54S6Ed45no21kwDIVQV6YlxMK7Q+UT2XXkdLcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzD+fni0OIr3SuLxIGjTw5Yxk+mKPf6WoOF4mOZgVkv3J59kg
	wg7dafefLRWov75OxdKljxqV3UPBHny8AmOSb6ufmFL06B51qlDy
X-Gm-Gg: ASbGncvqQgBysUcidVEZ/zNzKlT/fLOsgFFguU7k7F4S/8ZofxMlANaN3VLc9tnSfod
	oFJxgQu6RF4c3OTO6TAtRbgJI81dUytqv6ZI5awDNZnNoNDYTIFjtRrE50Mbvfgrjl0hOJ1C4bT
	0fVsh1NRS98pv5eDQoMOG9J0FPfb3ULm94LDW/n+D/gsuKFtiinFH/Vh8tOLJAih3KE7PJ0ja7G
	flGdNIhaxD5KxUDTt4PgZC6wc3xoY9FNSYCXN3XqzDgZLRF9PEDxgTbgEytzIylnH8GsQm7
X-Google-Smtp-Source: AGHT+IGdHfpyvROFDIoA/vrpeY27EHepsZCaEcQWYp+pKb7ao8KUnGmUedJ2CHzGefRTPm5k87aSVQ==
X-Received: by 2002:a17:907:9720:b0:aa6:81bd:546f with SMTP id a640c23a62f3a-aac34409f24mr1938160666b.60.1735141485330;
        Wed, 25 Dec 2024 07:44:45 -0800 (PST)
Received: from f (cst-prg-15-174.cust.vodafone.cz. [46.135.15.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f1aasm7607000a12.50.2024.12.25.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 07:44:44 -0800 (PST)
Date: Wed, 25 Dec 2024 16:44:32 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Nixiaoming <nixiaoming@huawei.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz" <jack@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"weiyongjun (A)" <weiyongjun1@huawei.com>, "Liuyang (Young,C)" <young.liuyang@huawei.com>
Subject: Re: [RFC] RLIMIT_NOFILE: the maximum number of open files or the
 maximum fd index?
Message-ID: <nkgz2gvz7pyp3qcvincc4ovkofwg6dzp5dgjyvzq7agwwqlmo7@52pgxfk5iqh4>
References: <4731d54723b841599882a24f7aa73aaa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4731d54723b841599882a24f7aa73aaa@huawei.com>

On Tue, Dec 24, 2024 at 01:20:15AM +0000, Nixiaoming wrote:
> I always thought that RLIMIT_NOFILE limits the number of open files, but when I
>  read the code for alloc_fd(), I found that RLIMIT_NOFILE is the largest fd index?
> Is this a mistake in my understanding, or is it a code implementation error?
> 
> -----
> 
> alloc_fd code:
> 
> diff --git a/fs/file.c b/fs/file.c
> index fb1011c..e47ddac 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -561,6 +561,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	 */
>  	error = -EMFILE;
>  	if (unlikely(fd >= end))
> +		// There may be unclosed fd between [end, max]. the number of open files can be greater than RLIMIT_NOFILE.
>  		goto out;
>  
> 	if (unlikely(fd >= fdt->max_fds)) {
> 
> -----
> 
> Test Procedure
> 1. ulimit -n 1024.
> 2. Create 1000 FDs.
> 3. ulimit -n 100.
> 4. Close all FDs less than 100 and continue to hold FDs greater than 100.
> 5. Open() and check whether the FD is successfully created,
> 
> If RLIMIT_NOFILE is the upper limit of the number of opened files, step 5 should fail, but step 5 returns success.
> 
 
This is the expected behavior, albeit posix is a little sketchy about
the description:

https://pubs.opengroup.org/onlinepubs/009696699/functions/getrlimit.html

> RLIMIT_NOFILE
>    This is a number one greater than the maximum value that the system
>    may assign to a newly-created descriptor. If this limit is
>    exceeded, functions that allocate a file descriptor shall fail with
>    errno set to [EMFILE]. This limit constrains the number of file
>    descriptors that a process may allocate.

Since you freed up values in the range fitting the limit, allocation was
allowed to succeed.

Note other systems act the same way, nobody is explicitly counting used
fds for NOFILE enforcement and per the above they should not.

Ultimately it *does* constrain the number of file descriptors a process
may allocate if you take a look at all values present during the
lifetime of the process.

