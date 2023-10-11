Return-Path: <linux-fsdevel+bounces-18-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7B7C473D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424F5281E93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 01:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1A2115;
	Wed, 11 Oct 2023 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o2/UHabB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EA20E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 01:27:01 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A78F;
	Tue, 10 Oct 2023 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=umkGY9vZvZGbLfMQqDCxm3Pw6ERI7CheDFT0ZxkT/ls=; b=o2/UHabBCEu+Y6IUsFuqCeoIYd
	FetVkMxVp9EQz+vT4PBgVJAngY5lNhc+qbxFZk1vT7SXaFCp+JO1HwqlaDr9O49Ds6wjDRHU94plC
	FYh0IRvbjTzpX/5ryHQCEtGPAFxzCO/6fTalNF0PWH1uslqRKCQvEjwZC4EgfFRTyJmiDZcu+PPuF
	3AeFklnyt6byAK1KkIFqJ9jzf5Tr02FdhHJbwMVR2bqYHA1HOF8kTGv1FTmS2nrjXarjYGceHXo/y
	56ypL0SPrbm0k0uCXMP8kQuycEXE4JGEnb/VVl4XRxpIn2DY0kHRFZ0J8nrfG3yLKVn1mrpmgvkUA
	h9jV7MKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqNzv-0006tb-0D;
	Wed, 11 Oct 2023 01:26:51 +0000
Date: Wed, 11 Oct 2023 02:26:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
Message-ID: <20231011012651.GS800259@ZenIV>
References: <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
 <20231010165504.GP800259@ZenIV>
 <20231010174146.GQ800259@ZenIV>
 <CAOQ4uxjHKU0q8dSBQhGpcdp-Dg1Hx-zxs3AurXZBQnKBkV7PAw@mail.gmail.com>
 <20231010182141.GR800259@ZenIV>
 <CAOQ4uxg7ZmDfyEam2v7Be5Chv_WBccxpExTnG+70fRz9BooyyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg7ZmDfyEam2v7Be5Chv_WBccxpExTnG+70fRz9BooyyQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:28:41PM +0300, Amir Goldstein wrote:
> > with making vm_user_file() do this:
> >         file = vma->vm_file;
> >         if (file && unlikely(file->f_mode & FMODE_BACKING))
> >                 file = backing_file(file)->user_file;
> >         return file;
> >
> > Voila.  Two-commit series, considerably smaller than your
> > variant...
> >
> 
> Yap. looks very nice.
> I will try that out tomorrow.
> 
> Anyway, it doesn't hurt to have the current version in linux-next
> for the night to see if the change from fake f_path to real f_path
> has any unexpected outcomes.

There is an obvious problem with that approach - refcounts don't
mix with loops ;-/  Sorry about the noise - this really won't work.

