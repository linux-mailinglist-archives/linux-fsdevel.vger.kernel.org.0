Return-Path: <linux-fsdevel+bounces-15905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F3C8959B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF35283EE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF80214B074;
	Tue,  2 Apr 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3qNaJE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C214B072
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075212; cv=none; b=ELF7H6puDIB6B/LJeOqMC7GXJvKkdgcE9JJ39POMypemZD3YGYWGU1nsqSKdKYwjyjt6MFaqZ6CskWeelc1IyGWaQFSMNVgvyGsXT9SRkCnXs7GH13osxhP4NrligQsonrdwUWpymdmY898vjcJzP8gB1YFTTUKtLH8ylamImFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075212; c=relaxed/simple;
	bh=F5+iyGUCvQpuV8lv12EAHUDCmUU3i5EFr4dh4MbLXwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqNlebyuwSUg7pb+3+LBtREslc69DOuhIcjzvnW27DROhwAiKIMRE62CkJa//825PThJDkkg5egD8kPlXrZHGeIKpwDufMRoUL1mCnVhBIwYeMVvndG/RiitkAva8NRUEJCRdGqyT+F2wZP7HXCClC1lTO7b7qTZn9emz9ErY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3qNaJE0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712075209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TpGFn21m1i2uNjneulzVfYfTm+8lK5ZR+k7A+k840E=;
	b=H3qNaJE0/eHrNDRcntWhOsyyjsb7I3r7M9z8wr4fX6ry+Yj8KU6MpqSy9thKMIhknsfZuH
	fJoAN9zoQUZW/BC+OgbyLoVquz8J+TerYUxpLkjr314cpwrfrWKf6edbAIcMij+oJRZy+d
	RN/UjntLli9l9pxi2MZ8POnV9EXoWO8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-WQyHf8cZOdiIQSqkOoAiWQ-1; Tue, 02 Apr 2024 12:26:48 -0400
X-MC-Unique: WQyHf8cZOdiIQSqkOoAiWQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4488afb812so333991266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 09:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075207; x=1712680007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TpGFn21m1i2uNjneulzVfYfTm+8lK5ZR+k7A+k840E=;
        b=pz//5RAYYyc9yolvp+/JyPmf0TYWAAvt5ZsB+teTyG4hGdjb9h4RNQLP+/3fVoC8dz
         SJuL/mU1ZReQkZMyVPfINh2BxOJQX8jRhGD/m0O4coQFnx8eiyJEaPl8IxDL1213/u46
         7Z62l0UEK/1xMnz+lK7x9Mb7yB4dcj5JWN035kQTP69PmLdiD06h41/sxto6Rx7ocnTS
         Ufb5uioz1dLwyUsvXtjYZYexsjLi1jKJ9lzKfcMR3i5F0ejvaryUo/8WUDrXHhnAHAL5
         bnE2q6ARbMTuq36aSjptNSlQ1eu4YLCdltzWdIZmHkJv51GhQJgzLhS1POXAR3Hb3McI
         7rCw==
X-Forwarded-Encrypted: i=1; AJvYcCVjMOigavCIKjFD4RUIwC82iRb5OhnYbIkRhAOz3hqH9FJxVjVMpnpdeWH67RNEmERdn0D2q41kDYShvbrloSE82OZMfJIfcmkmeBuSzA==
X-Gm-Message-State: AOJu0YztNWC6OF76t7ZP5SYS94E37b90zg+V/SmsuPc9YcyrX/zJIFiJ
	Sthoov/q9ysJfDlkEJ4JMtHnPtAPEJKuR0tqsrGDRqibdd0/IkenSBhEBbccHWzIawPP3NMXwqJ
	KjX5ASuTqbslxld3NmIZGxJEiNo5Uch+FZ5WwESW5A6gkAMY2XJAcYumSbinUqA==
X-Received: by 2002:a17:906:1390:b0:a4e:3a09:4854 with SMTP id f16-20020a170906139000b00a4e3a094854mr179147ejc.61.1712075206746;
        Tue, 02 Apr 2024 09:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbgALg3k0jk88bFML2ntWceIt+4WbChdRCLZb4p2oD8DsKtXsq8JdftPPwH7GoLWKYGoeFWQ==
X-Received: by 2002:a17:906:1390:b0:a4e:3a09:4854 with SMTP id f16-20020a170906139000b00a4e3a094854mr179128ejc.61.1712075206163;
        Tue, 02 Apr 2024 09:26:46 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id bw17-20020a170906c1d100b00a46b4544da2sm6658587ejb.125.2024.04.02.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:26:45 -0700 (PDT)
Date: Tue, 2 Apr 2024 18:26:45 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 26/29] xfs: clear the verity iflag when not appropriate
Message-ID: <smmx4hendu6fbin2kcuowsmlvwjm2nmqk7bd3mce65qawpf4ej@5d6demmjry5e>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868990.1988170.5463670567083439208.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868990.1988170.5463670567083439208.stgit@frogsfrogsfrogs>

On 2024-03-29 17:42:50, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Clear the verity inode flag if the fs doesn't support verity or if it
> isn't a regular file.  This will clean up a busted inode enough that we
> will be able to iget it.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/scrub/inode_repair.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> 
> diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
> index fb8d1ba1f35c0..30e62f00a17a6 100644
> --- a/fs/xfs/scrub/inode_repair.c
> +++ b/fs/xfs/scrub/inode_repair.c
> @@ -566,6 +566,8 @@ xrep_dinode_flags(
>  		dip->di_nrext64_pad = 0;
>  	else if (dip->di_version >= 3)
>  		dip->di_v3_pad = 0;
> +	if (!xfs_has_verity(mp) || !S_ISREG(mode))
> +		flags2 &= ~XFS_DIFLAG2_VERITY;
>  
>  	if (flags2 & XFS_DIFLAG2_METADIR) {
>  		xfs_failaddr_t	fa;
> 

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


