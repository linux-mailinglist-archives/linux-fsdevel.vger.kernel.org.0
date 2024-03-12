Return-Path: <linux-fsdevel+bounces-14198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C98793D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADD7B20A0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0357A71C;
	Tue, 12 Mar 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHET3Yqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AEE7A718
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245414; cv=none; b=Z0AiWfd/To8GNtkn3myW9JBUQMGMXnVMug2zpaFQMIHWmzyQFdF+WYRPzR1J63iKTOnH/+dc1inCkfEF7evfIPC76xYWupBo1Ixy5rVqvRjZyQJN92NF/E1maM92mzjiTJxOLG03zS7SwYSPCO9+hPzarXDeFnKjpt1d5fqvd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245414; c=relaxed/simple;
	bh=QmejXV0WNaqWu+GRV+FolZ1Mzxp6Le/AUayQOP+glBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt7yEgDZxKrcnl2CXl3VQ8ytVCK5VWm4gflMHqN3wSacLcPNyOvPxqrT1VdBBZq2pplzvbAArpG2fL8ODvqyq/eq29gkqUijeNGVmykEKwp15U568xVDWXWn8AkRixRzWpdnNX6ue9n1QMlvBSend465RRPaR2gW2QQcGY0lOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHET3Yqx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710245412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31/cMpUBlNq1dVo/GBGgzVo8ufDRVUmygq7sRPjG1Qc=;
	b=bHET3YqxamXWzM+6S1DIGP3RQl78gEPgE7lvZl9IiRkFNgpK/7ywdGx0bSruJBfGoNb8mj
	vu9pW6jJOcAy4Cdb2x6IQtAR9dPtDIrF+WYDcGfVRGB+Mi6P2wWgfzbRsXjZsvrZW75oON
	TEixnOgKpxqkJTrFN+zUCUNct74Q2+U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-mlhyefvwOlaK8rbGgwQo-Q-1; Tue, 12 Mar 2024 08:10:10 -0400
X-MC-Unique: mlhyefvwOlaK8rbGgwQo-Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3fcf5b93faso274193366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 05:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245409; x=1710850209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31/cMpUBlNq1dVo/GBGgzVo8ufDRVUmygq7sRPjG1Qc=;
        b=LOA2tGLha0mJ81KsWFH/ZGsgZkuQVAv7l3Eut8WSm2yxGjGpvPWZXe5XXs8YJeIeIj
         RqOzPBCrtu9pXYbFzUraiYCJHwnlaKyXrtskEvOYMej5wmtxx0U5s1ClSReWsTggtARV
         ZKM5usblPsW4/DrDSgxkcHhns41YojNLcbWeMERAvppa/th1ao09CBy2jnlpUcbJOPus
         36bGr+zEI+C1occ3ujF2XhCMVitN8OhqeewtXWMWOedWitfZV4OhfGs67SP22oHq3pEw
         p2CYTdBzMqLnGGczVcwCTNAqPfO6jzL3CDgzZKscRX0CpEQB3TunFdYorxFLZ4EODMF3
         qYWw==
X-Forwarded-Encrypted: i=1; AJvYcCUFiZfzWd+XoBJC+F7nDVo5JGd+iFSGQITwdBYDCyP+07GSEi/sPFaj+HvMjw46V9uctdMPt/M/58nfzvI89J5hHerpsgzjU8PAZiYHFg==
X-Gm-Message-State: AOJu0Yz0ZVUN3otxY949fIXlyBB4tR5rrDjeyE0JRo5YDbAJClr2V1Zo
	dRhl191ikaYSku34fR8BwIOqZNDiAQ+vtZ6BiI1tDgZwtiDBRW4FHb30WtXxitcUIa+FIeBeVwt
	4MXBhrDt5DrIISsyDXhtvXBFXvQwV6VnmT5vvDVTaJGCqmbzV57X6yJbdIbkOoQ==
X-Received: by 2002:a17:906:f854:b0:a45:ab61:7a47 with SMTP id ks20-20020a170906f85400b00a45ab617a47mr110675ejb.16.1710245409325;
        Tue, 12 Mar 2024 05:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcFKEllu/5Cbuy41Q4z4pVzuQCoPfYq9eSirKoM2GYu6wrbDVHhEhhps6AcIx6mCLMUFmsaA==
X-Received: by 2002:a17:906:f854:b0:a45:ab61:7a47 with SMTP id ks20-20020a170906f85400b00a45ab617a47mr110620ejb.16.1710245407792;
        Tue, 12 Mar 2024 05:10:07 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906a10d00b00a4605a343ffsm3384399ejy.21.2024.03.12.05.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 05:10:07 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:10:06 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 22/24] xfs: make scrub aware of verity dinode flag
Message-ID: <iag66iabauxkow5z2cn275gjtbaycumf3u6lsyljzuascylbto@d23xbll7dx6n>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-24-aalbersh@redhat.com>
 <20240307221809.GA1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307221809.GA1927156@frogsfrogsfrogs>

On 2024-03-07 14:18:09, Darrick J. Wong wrote:
> On Mon, Mar 04, 2024 at 08:10:45PM +0100, Andrey Albershteyn wrote:
> > fs-verity adds new inode flag which causes scrub to fail as it is
> > not yet known.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/scrub/attr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> > index 9a1f59f7b5a4..ae4227cb55ec 100644
> > --- a/fs/xfs/scrub/attr.c
> > +++ b/fs/xfs/scrub/attr.c
> > @@ -494,7 +494,7 @@ xchk_xattr_rec(
> >  	/* Retrieve the entry and check it. */
> >  	hash = be32_to_cpu(ent->hashval);
> >  	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
> > -			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
> > +			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
> 
> Now that online repair can modify/discard/salvage broken xattr trees and
> is pretty close to merging, how can I make it invalidate all the incore
> merkle tree data after a repair?
> 
> --D
> 

I suppose dropping all the xattr XFS_ATTR_VERITY buffers associated
with an inode should do the job.

-- 
- Andrey


