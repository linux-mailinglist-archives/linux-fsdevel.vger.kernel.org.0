Return-Path: <linux-fsdevel+bounces-57947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F6B26ED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5EDAA07CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F893225408;
	Thu, 14 Aug 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ko1yaJ1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F721A44C
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195937; cv=none; b=bty1ZTvrm2CTOvo02294EeBddUvBx0RNqDO+4hgs/2i1T0BkO6S+LpWizHyZLF7HJO13t/6JGuA2Sk1PVIyeapP8afROE08HkT5nx7vu5hiH4rqhmV7ou5hFOPeDZKzdp0Ay6i/w/tGX7Dhf29jZAl40xqAkiVcshOvkec4yTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195937; c=relaxed/simple;
	bh=QlxV/Fo/vL6WCJNsSwAfnDwsEr9HvLtREXvO8jaWoVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLDsRkObHHDVcwTQuLD8fu74lhl2NgcajIVdEu5grVaaJxL4mPRgAnwoIfRuh1XfWm1Ad2OQ9ydf3aMossUCwHRYffDm7uapeqGmzY1W3rsw7BaR+zz7g5njLzNGER1ozmQ5+15BGRqJ6POXafDz9wl7DWkiD+eIHrYH10QVdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ko1yaJ1J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109bcceb9so12982381cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755195935; x=1755800735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaG/9Mc3gO9Z05dXGGeK8opCDGdDbOMVGSG4B2PlDgg=;
        b=ko1yaJ1JMyXmfvMTXB7j9EYtUf4g8Ob8wi0QKyQLB6zSJwBFHgye+nIkfRwA5sHaD5
         vFMD4P+YScuUtz6XGI0kSMNDuvJfzyaRVD3QKounFxB18buI4bsRMakeb383C6CynIQc
         nZdVeIxc3MWo+z0MtXrcucnhvg7NMO7KTR1f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195935; x=1755800735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaG/9Mc3gO9Z05dXGGeK8opCDGdDbOMVGSG4B2PlDgg=;
        b=hbR6F9mOd9XpMDkVqHj3mhq+//MxG2k5xsILbXnXpKoxnWPMCEPxr80lnnrCVjncP7
         drwuPYWh9G+CmNrnD2fUur2h+luWyWgwyhzLdPtp3Vag4T0rjh0OXZDZXJjwwjEZcdFy
         mWWLJONVuqI5QI5tswztJQ2U8WU1T/KXhN9XZUpSrKVAWKT8fggW7KyQhrku8aXY37Dj
         ZJ6u4u33UcNKe/k0Ng71v9p6OUnPiJs6obrktLn39fjIqTckV2wpNaebRObsVRXmj5Tv
         CK6U4lJo+Rz6qEChbqv5w+T9eR2HQoQ5tr6agc7lGN35oJKCo86cvzMh4pGEm79D0Eep
         F1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhdwoxxM1IAiET9a9+XaYwvICBbYSxSuHGH6mFonNCqjDjy8qC/tjqAJvMfSgOipzsSxtAgqyeRDLyJLlt@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZBPc63VcQDAmTuZCa2pzZXjQnj6mf7vVp6nvPCEnFxP2hbD0
	1HQEwJUrJa1HRX93YaPX23GHME5UkWNdw92LNIjfNBXKdEgz3kRgTAB5njuxQifB5yZU+VAXu+W
	2hylAXNd8JL6gGKGSVoyxjFl8v4s0Icyc/+GP1r4hJg==
X-Gm-Gg: ASbGncuy6ohDpZygf61XYsy6rzUJXDHeozOBIyqlGzakDubIXy0BDx+FCrlv9WVT3Yg
	zuPG9aZ8WP0zSl31ClCW9XTCNAd15alOuwH+vlqZLx9vNFHokS6Bv9YRyxSkWXPBSKItTmZL8jQ
	4Gg6zMWvC2GXDN1kgA6vp5GHLoEc10/wJonpS6Xud4D1aSBu3PgT0O6Q+CzNYdPEcemJ2c7hGf7
	VSg
X-Google-Smtp-Source: AGHT+IGSn0lQHqZ9RP9BbaqY15avh0lMZ+NAOhYoifmbXNq37t8nR6rR8emWPkr9ymaCKi05XQKiq/L5hGeuPEvoQWk=
X-Received: by 2002:a05:622a:2c3:b0:4af:21f6:2523 with SMTP id
 d75a77b69052e-4b119812238mr5676291cf.6.1755195934739; Thu, 14 Aug 2025
 11:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com> <20250814171941.GU7942@frogsfrogsfrogs>
In-Reply-To: <20250814171941.GU7942@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 20:25:23 +0200
X-Gm-Features: Ac12FXxTdDrnRb7Tf9wOWEPTOrq-mapbwGaLhT9s1IZLVbyqxOHLM2quCQmv3sc
Message-ID: <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 19:19, Darrick J. Wong <djwong@kernel.org> wrote:
> What happens if you want to have a fuse server that hosts both famfs
> files /and/ backing files?  That'd be pretty crazy to mix both paths in
> one filesystem, but it's in theory possible, particularly if the famfs
> server wanted to export a pseudofile where everyone could find that
> shadow file?

Either FUSE_DEV_IOC_BACKING_OPEN detects what kind of object it has
been handed, or we add a flag that explicitly says this is a dax dev
or a block dev or a regular file.  I'd prefer the latter.

Thanks,
Miklos

