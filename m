Return-Path: <linux-fsdevel+bounces-31930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937499DCAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A174C1C21642
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 03:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7340170828;
	Tue, 15 Oct 2024 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIqoFCu3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2124B28;
	Tue, 15 Oct 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962469; cv=none; b=jGqxcJPO8DJZ1iXcWFJ/idU1CPcktBPjcT++eh0yEX0uTLt+X4Lm1bWxazb++A4Bns70XY6it8/7sEWgoaSXeZtOy3C1UkR0QjSaMRkgci/EsqPPO2I6/buknlRvc+j21R+y7zYRoD7OwTnbgcVzrWDi3iH9Fy/Ay6Hr93i9/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962469; c=relaxed/simple;
	bh=6GU14EHAskdr4mkFX20oaALVO6IMc8fAdjuAO4mVF74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSzOW1FtWjuwWC3+Daf4Ve1rDkWu8e5/fr6HqLjQWmcjdEhSl4/DUQaZuT+1NHdZ1dcp1LpSx+a/wmxdOY3e2B+0CWpkFjNXfRIKQnDtv4j3wm4JlAMPPvp0QcWt8v4SHBIhVVRciH1yFLNkm44Tdlk1ZNHLVzElribIG6CvPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIqoFCu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA012C4CEC3;
	Tue, 15 Oct 2024 03:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728962468;
	bh=6GU14EHAskdr4mkFX20oaALVO6IMc8fAdjuAO4mVF74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIqoFCu3sCLdSPCkyuHRyP8tYwfelfi0NJNWhErYSrWlp3q7YI8ncg483C+nIsX/s
	 Q0vzBy2JNDb9aIE4chnaSzJrPBJ9T/CyeQYt+G9NXQbe5kf8jvcaT71aIhpy911ydD
	 3LcOGuF8622H9E3MVs3MrRA01cB+kHrV0szgmmdNdpKv05Q13eqdUFl9PukN0eoqbp
	 WpOmfYJxc8HI604DZcc+suQ0RCgzpkdOvrf3c+Nkf6eq0drI33SBlXr7f6U8sw0zGI
	 wLC/SFW1Msw3NfB+8VHpuswOLwOla0ehBGX9J647WP64G3+81LFEQanuqa0WLoD5CV
	 +6uJP56Tt32fw==
Date: Tue, 15 Oct 2024 03:20:55 +0000
From: sergeh@kernel.org
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v20 1/6] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <Zw3fl8OihgUay_53@lei>
References: <20241011184422.977903-1-mic@digikod.net>
 <20241011184422.977903-2-mic@digikod.net>
 <20241013030416.GA1056921@mail.hallyn.com>
 <20241014.ke5eeKoo6doh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014.ke5eeKoo6doh@digikod.net>

On Mon, Oct 14, 2024 at 09:39:52AM +0200, Mickaël Salaün wrote:
> On Sat, Oct 12, 2024 at 10:04:16PM -0500, Serge E. Hallyn wrote:
> > On Fri, Oct 11, 2024 at 08:44:17PM +0200, Mickaël Salaün wrote:
> > > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > 
> > Apologies for both bikeshedding and missing earlier discussions.
> > 
> > But AT_CHECK sounds quite generic.  How about AT_EXEC_CHECK, or
> > AT_CHECK_EXEC_CREDS?  (I would suggest just AT_CHECK_CREDS since
> > it's for use in execveat(2), but as it's an AT_ flag, it's
> > probably worth being more precise).
> 
> As Amir pointed out, we need at least to use the AT_EXECVE_CHECK_
> prefix, and I agree with the AT_EXECVE_CHECK name because it's about
> checking the whole execve request, not sepcifically a "creds" part.

Well, not the whole.  You are explicitly not checking the validity of the
files.

But ok.  With that,

Reviewed-by: Serge Hallyn <sergeh@kernel.org>

thanks,
-serge

