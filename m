Return-Path: <linux-fsdevel+bounces-74150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C66AD32E8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 817F8302403E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7AE145348;
	Fri, 16 Jan 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB4HYyfx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mschl6yR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579F23E342
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575139; cv=none; b=QJ92yNDF6jDim4R9UlrLafxMU3tjEGelzAYPG7HrwgjHFbio4m0KW7aYzRZLbHxz3NGKezQJMeir9kdYgLqsVo+7Yw8AIxhCMgIcd/X7yr/z/g//AjGW2SSxVVbrOri27PF+cLdImSZKsGYROuVWtRQIl36O85Sv2nmS/75/j+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575139; c=relaxed/simple;
	bh=7cGeMk8GyRdqCvDdT0G0vEEeDlTTsLl/4l41tbPOOLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLGIzcCUEellzr1gqStfyUFEggPeofixx037lqQMKIwpmLulpE3VeKiwRWdBb13CrCIjFL5QBkQa6I/dY6LEcJog/5yLeBTR6SccLd+PaCg7kmGetuBqZztqI62hwdF4PCsEZJwoBK/drSV+7ybmLTFXlUyqv2npxyc8L5ZT5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WB4HYyfx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mschl6yR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768575137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0h8VbcliXJU5w8d5JITrLYVgYncPw3n5MJT/9tJnIiY=;
	b=WB4HYyfxYtZnufUlvKIo+8nLniIYYJbfRWAjiebLLa3Xz/lO7eDcJg9ZSrwUsKLgc4Lgbx
	pkJQRecdfWfNDE+xANtmAdiBCvO64jorHklmI1hYh6UCIpLw0FhII5gyUS59umWkdr2Mk+
	9UDwRou+U08eMTmm0IzCLI1oeW0zXv8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-L1ObJCECPU-jx_VV1-rQuw-1; Fri, 16 Jan 2026 09:52:15 -0500
X-MC-Unique: L1ObJCECPU-jx_VV1-rQuw-1
X-Mimecast-MFC-AGG-ID: L1ObJCECPU-jx_VV1-rQuw_1768575135
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43101a351c7so1827674f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768575134; x=1769179934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0h8VbcliXJU5w8d5JITrLYVgYncPw3n5MJT/9tJnIiY=;
        b=mschl6yRVQS+DtwWHfp3xugp7a/voGhBSSAXCed+4WaF33U8gYDW8SDwbylxMEAX+E
         F5Ilyt9dmahvWxjOGgx5nG3XiIJrQeZIAW0yMYdfbNs5+wnOITtBHiXNbHNGy3y3UoRV
         xmddYIp8A7Fi0MCiDLdP9pCU4WIKSlg1GZsv8JK7ZrzG//wWfdp2x9E2IFGNAurUQdG3
         q30iTML/7CNXZ1ihkPWfipKDFf9u+9mJDR0r6uz5v+A93tbPYnAeGk2a2vM+M0C50jgX
         koGSvCKaQBWI1RAethdlEG4cICqeKsTc4p70MnJfAYwfl8UbNq3onDo1Z7X2iynw9XGp
         ALQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768575134; x=1769179934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h8VbcliXJU5w8d5JITrLYVgYncPw3n5MJT/9tJnIiY=;
        b=p3cDf4C3Z+tB8uYbSTNdb/4BFewRQRnsFd76sIPFh6URGFThSXzl73F7GW0dqEn6Of
         4hefNVMdCk3COrnGoH6zxpUVmhG74OKgzq8EGJa9dmHVtCvaKa4H7zL7ZaEQ60jm+2Sj
         RYBGKEMpe2l2qytElaISk1KOciYoPogXki4qofnjEEY8eNVoiRcnOqLbHwiMh6aBKv6I
         qp/Pk3qcOR9yGeM7mBrqVP0Y/ZpXc8v9ay+2jtaX3Fhf4Osrnt08lM06uPDzO0hyf+8x
         UhwPf+R3QHjkf3XqvVUFP8MqoS0BMqYWpC3HJ1q9tc2gNTE6IA2dWL2IATdBndaEw4EW
         MoFg==
X-Forwarded-Encrypted: i=1; AJvYcCXExjJaGiue+nzK2o1UGDB8/rB+z2T/w72b5YFYV3D6ibhOOUHgNXXvugrpcF/Tgyd+J2xLstvhDLR3e2+Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFUhpz2V1KXewZcswml+MtLjCpVFn6TL+Ua2mlZ/UNVCYC8mN
	2hJPZA07y4wQQ0JcZyxMApVT18o2dbk4P9sr0CFD8MP52Uj3SQw7K+LDm5KUxpeerLOcnCukf+q
	ySo94voq22VlWfbFQG9MSEi+ls7sKf6ZTktdIjEDfx00nReUrB2NwmM370FW/EBAvKw==
X-Gm-Gg: AY/fxX7SPV9XRS7IaoXP6JlLI19+enJY2dtPK5VxWj46gPKAutL/aMGWepc8UlloP1v
	HYmqqscOO0NTGY95cNwile6FvYJvc58KK7aKLL/WqqZ+vu+c/3OahcxNsUnUhvgX7SsEG2WfW6v
	2ICm/u2SXOwHP3hZh5qlFD44BO8XFYDXnr7bO5rrvBkB1bmXFNDer7tkUXxMFrXT4OjiHacHODX
	wJ+L2xP9npi6vYTHJcDVy1RiJ4U2fEdB1v/RZZ88I5S4y+DNKcgX1YyMePVV2jrECVXE97dbNxg
	5mRJVlnYUPhTz2Nz46njFa88wJWBxcNvV/XVgGzRDvv/VEAw02824tfZkhyizOilpeY3wgv5ONo
	=
X-Received: by 2002:a05:6000:40e0:b0:431:701:4a1a with SMTP id ffacd0b85a97d-435699997a3mr4331551f8f.26.1768575134297;
        Fri, 16 Jan 2026 06:52:14 -0800 (PST)
X-Received: by 2002:a05:6000:40e0:b0:431:701:4a1a with SMTP id ffacd0b85a97d-435699997a3mr4331513f8f.26.1768575133696;
        Fri, 16 Jan 2026 06:52:13 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996d02dsm5633075f8f.23.2026.01.16.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 06:52:13 -0800 (PST)
Date: Fri, 16 Jan 2026 15:52:12 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 16/22] xfs: add fs-verity support
Message-ID: <5s37vliyxikgz22dakooeml37yo2jnhqqinnnag5czbtz46io5@h6jikziw3qxr>
References: <cover.1768229271.patch-series@thinky>
 <p4vwqbgks2zr5i4f4d2t2i3gs2l4tnsmi2eijay5jba5y4kx6e@g3k4uk4ia4es>
 <20260112230548.GR15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112230548.GR15551@frogsfrogsfrogs>

> > +	desc_pos = round_down(desc_size_pos - desc_size, blocksize);
> > +	error = xfs_fsverity_read(inode, buf, desc_size, desc_pos);
> > +	if (error)
> > +		return error;
> > +
> > +	return desc_size;
> > +}
> 
> You might want to wrap the integrity checks through XFS_IS_CORRUPT so
> that we get some logging on corrupt fsverity data.  Also, if descriptor
> corruption doesn't prevent iget from completing, then we ought to define
> a new health state for the xfs_inode so that it can report those kinds
> of failures via bulkstat.

yeah, iget will complete as it doesn't trigger fsverity to read
descriptor. I will add a new health state. Thanks!

-- 
- Andrey


