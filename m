Return-Path: <linux-fsdevel+bounces-70241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E43CC94467
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 312004E357F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01F30E0E6;
	Sat, 29 Nov 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLZGAE7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAF3A1CD
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434868; cv=none; b=fxT+N0qhB8RDBOumqE0M0ki73DpzJNNS1XxS+yhLlQrRO8leus7YHqF96O+GC2AgdPI74XQ9XRu6prTikYflYmwGYE8pZBH1AzRoKOo3Puyo5AhY1ito7IdF/VDU/TIjLKxz11ApomcsMbGS/pLN4r2qImaNLdo+xt115ZFyLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434868; c=relaxed/simple;
	bh=lfXocuAK/pWFxfOrTNg5yzIeqcc91Ezqf3NtrGk7lPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Fsk4+br1D7RcZFDkOjOzAlaVLX5X1EM5sKjX5SXMbjIXmiqp8/6pc2xt8TkkQER+eoj/scaoFCGgOABY07wtsNXoPq6Tgozfv4Z/tu5vDsovkqK+LegRXbUYXcBUZiw76zLYwBk6Dyd/naaHJrkW3fdkZWqU4B/p/Ya54/ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLZGAE7v; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775ae77516so29051275e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 08:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764434865; x=1765039665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q3ych/iH++Burly7REfAIiFBvK9CWqovdUB/sBoH0wI=;
        b=sLZGAE7v67LEK95/OEJzyVxH4+D0Bj0RPFWN1j3Ih6DIkB1SZT1gTchXIIr2wYAEnk
         L0kWgu0FZ1jq0RzhLLdfk2RwCOAu0EVYo6zGqMmtaRvkajxAQB8O+KIE+sj018iDt0g2
         Fq23960xhDHYx7o8KhhwVQ/YswI8kA1Qeq7moUpA4qJHnFWfr93JaEjDnJGmJrn+7b8e
         emUgDglYKOjJRjf7Eb3mw6IcHp7TGxY3nniLnXLSSl0jrHh/xsUeXFTDolJm1zYdiwut
         dGfMI+dX+LlMD3vQ0ZtX9G4eGTXm8A2jbGkEcwu8FwTuL4KFf6V1hW+F7oNaUBKU0+/x
         KDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434865; x=1765039665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3ych/iH++Burly7REfAIiFBvK9CWqovdUB/sBoH0wI=;
        b=aoOOAknOaCwWsB+9VdNqX4NiJFynGYdJ2+v9yGccMkEUdOH8+KU+HXZ6F3wQIS61pz
         sDdrTFRBEqUjvsOmcSDUbdQ4zgRGeEYBMSSXrqkgTQVTOtwtA3MnE3VCvFx0pDr0TTRa
         yIcVeUgS/2eqi0q2Gl1FdDejhtfqvJWcFbtEgsYHTPBPJGtK0TPafwsX+PQnEqz9N3LC
         STbtE/foiu3MoU5oZLgfZoh0c1HLX2SDyF7zR5FE1bAPwbNr+eZe0+IoIJcvifMhLAI3
         0WHM4a13cfuUlwS9O8Dik6leep+IjnX/AIuWb7SXYhDUT/4X5naJBiBWN2k5Q5L35W42
         Q6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWPg2aOQsmag3I8OGdAElCd+uTTmwsx3lQauX7s33QU+hIEig545hEzm/58fwwqF5D7YhCVKdJYtZ+fC4O@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4K4NHB6lLAailofBaWmtag17mZ+01YsaqBLMxu5SeSYJUfbf
	4rxsFayUa+PMgEWs571FXuP/f2BTeuvi4fNY33tpaBWys56YLslJYIM4XdgMQTKiIT4=
X-Gm-Gg: ASbGncuz/2HtWftI31DSYnZE/m9iFPGbdf8HkR7Qm5MOMjDiNT9803am863dmwTyN46
	wiy1UooClO1JuTocGYdt3EaIMQO57NMnvUdT7KQTLn9HFcI0jvwXSjO/J+aWmugNqevC86A7BhN
	ivlRvSvrToAr4pFfcJSbmcUvI+B1nLZjA1Qx9Y5s/Q1leL00d0YKkc8LOs0Nif2OXHWActdj52B
	31C1GOh2AA86fEdk8UKQii2eJpc5iUhnCTNjU8C5qMKaJ6eFKg1gobRMbhgZPEHAbZPxQ05+5p2
	BUFHpgpFX8wKAWEJPakWXsd+w4N5BhujGRauHxWSr06VVCOCd76l+2KJ4YhOStNcn8dC1bhcMzn
	aEwOk0LunqcYYqhmtLGrjvlEAGODdAVvEs7AxdKbiVNaqWfJnuGJNiDvEQWnD+w268yQWUAHDnh
	0/LzbD8j9aJ7R9pJvPVf63p09711M=
X-Google-Smtp-Source: AGHT+IHWC/GnPcXEFcRMCb0gXQ0gjyiuDDgkjLVVLavOmK+5nIoumamUjPkBQTmCBaMvnDlVWFIUqg==
X-Received: by 2002:a05:600c:35d1:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-477c10d6e76mr367577405e9.8.1764434864537;
        Sat, 29 Nov 2025 08:47:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479111438b9sm163292285e9.2.2025.11.29.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:47:43 -0800 (PST)
Date: Sat, 29 Nov 2025 19:47:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
	idryomov@gmail.com, linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] ceph: fix potential NULL dereferenced issue in
 ceph_fill_trace()
Message-ID: <aSsjrNnuC3hHtu8F@stanley.mountain>
References: <20250827190122.74614-2-slava@dubeyko.com>
 <CAO8a2Sj1QUPbhqCYftMXC1E8+Dd=Ob+BrdTULPO7477yhkk39w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO8a2Sj1QUPbhqCYftMXC1E8+Dd=Ob+BrdTULPO7477yhkk39w@mail.gmail.com>

On Thu, Aug 28, 2025 at 12:28:15PM +0300, Alex Markuze wrote:
> Considering we hadn't seen any related issues, I would add an unlikely
> macro for that if.
> 

Using likely/unlikely() should only be done if there is a reason to
think it will affect benchmarking data.  Otherwise, you're just making
the code messy for no reason.

> On Wed, Aug 27, 2025 at 10:02 PM Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > The Coverity Scan service has detected a potential dereference of
> > an explicit NULL value in ceph_fill_trace() [1].
> >
> > The variable in is declared in the beggining of
> > ceph_fill_trace() [2]:
> >
> > struct inode *in = NULL;

Most of the time, these sorts of NULL initializers are just there
to silence "uninitialize variable" warnings when the code is too
complicated for GCC to parse.

> >
> > However, the initialization of the variable is happening under
> > condition [3]:
> >
> > if (rinfo->head->is_target) {
> >     <skipped>
> >     in = req->r_target_inode;
> >     <skipped>
> > }
> >
> > Potentially, if rinfo->head->is_target == FALSE, then
> > in variable continues to be NULL and later the dereference of
> > NULL value could happen in ceph_fill_trace() logic [4,5]:
> >
> > else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
> >             req->r_op == CEPH_MDS_OP_MKSNAP) &&
> >             test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
> >              !test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
> > <skipped>
> >      ihold(in);
> >      err = splice_dentry(&req->r_dentry, in);
> >      if (err < 0)
> >          goto done;
> > }
> >
> > This patch adds the checking of in variable for NULL value
> > and it returns -EINVAL error code if it has NULL value.
> >
> > [1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1141197
> > [2] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1522
> > [3] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1629
> > [4] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1745
> > [5] https://elixir.bootlin.com/linux/v6.17-rc3/source/fs/ceph/inode.c#L1777
> >
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

If this is really a bug it should have a Fixes tag.

> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/inode.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index fc543075b827..dee2793d822f 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -1739,6 +1739,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> >                         goto done;
> >                 }

This "goto done;" is from the if (!rinfo->head->is_target) { test,
so we know

> >
> > +               if (!in) {

that this NULL check is not required.

regards,
dan carpenter

> > +                       err = -EINVAL;
> > +                       goto done;
> > +               }
> > +
> >                 /* attach proper inode */
> >                 if (d_really_is_negative(dn)) {
> >                         ceph_dir_clear_ordered(dir);
> > @@ -1774,6 +1779,12 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
> >                 doutc(cl, " linking snapped dir %p to dn %p\n", in,
> >                       req->r_dentry);
> >                 ceph_dir_clear_ordered(dir);
> > +
> > +               if (!in) {
> > +                       err = -EINVAL;
> > +                       goto done;
> > +               }
> > +
> >                 ihold(in);
> >                 err = splice_dentry(&req->r_dentry, in);
> >                 if (err < 0)
> > --
> > 2.51.0
> >
> 

