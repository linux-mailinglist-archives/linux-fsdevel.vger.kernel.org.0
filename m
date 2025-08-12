Return-Path: <linux-fsdevel+bounces-57539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC2B22EA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70FCB16AD3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7972F90C6;
	Tue, 12 Aug 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGOA667q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B923D7E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018692; cv=none; b=nfWZ4I/hG+7pZdMd3c88/skwRPdbhUhi975zurfxBANqwkHOnHsNI1pXWKhWbtGN47nU8eSMzw2CxILIj8/jEB+B2nsuanVgQKy/HsL7pTTb8DJztOeT2T2KOUVXPKr+FWKHcNBfucldJ+LzPF0Dr0giTfUSEeadPSSTZxNe06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018692; c=relaxed/simple;
	bh=7rbRck077Xr3QB/yKuzHkUIMG+GnCWEWE8m7/2tPOI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sny44CAZCvB03EYTzLOAbWcwXJVy1HlNndQugP6rebXSrDrHDUesPpK1mg7ZfSOlWwze1e16AOi7F0uNyLGukxpw9PM3WcPmR+FYClHvePhZTJzTIsdZje/obuCLatCQL+OSzHfud/b29RFIhKMsBxYIysIsa+/+Hrz4Ah+uLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGOA667q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755018689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cP2OHHmo9urpEPIW8P+jTI4EpHMpDkapbSQ2TBaCUcc=;
	b=hGOA667q+H9Dg4RXTgDpLhbp4Qr0xLHA6GVw9EHe0ouoAod7SvagHNqwbeu4eEgeGiY0rs
	ugd85LZ9MWCfy/mBJV+7flpzH4r2xaRd1hpodB7q4tjy0PqhYW/OvUptK3uQIFz247q3eA
	wetM7vBzJ7EdG0QB9qiC0rB885eZQ6w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-loWZKavTM9Gpkxq99wFRGA-1; Tue, 12 Aug 2025 13:11:27 -0400
X-MC-Unique: loWZKavTM9Gpkxq99wFRGA-1
X-Mimecast-MFC-AGG-ID: loWZKavTM9Gpkxq99wFRGA_1755018686
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b78b88ecfeso2998384f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 10:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018686; x=1755623486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP2OHHmo9urpEPIW8P+jTI4EpHMpDkapbSQ2TBaCUcc=;
        b=nrm3uBVzanJLDCdmC8u/HfgUiKUogLdMUkWT30gPoe7xB7QyLYjkkrSD61yUwGQj2v
         d0E5WqpKhd1B4oix53G9bw22th4X82XGnKWkbrSZsRRc8vC9Ml8tKaMU7izHBOmR9P8H
         Qo8kstqXSx2EdbBmGKYCOyhXDrnU/vjB+9Jm1bYE+fjD7SSx5iI9ORdglDGqMOe+MD+W
         ArGTdxfnFqa1UarVpI+pd1BdBOFajLV3D5fmxUv+3iPojSvN720AY1w8abW/zw8cjWec
         Dlrf6OBbM8umRFpJim4jjhTwOObKAEMLpYDIOUwJMEjJPFETvnxg3FnfBUyogAx5xckh
         R3OA==
X-Forwarded-Encrypted: i=1; AJvYcCVPFMh2d51/iadsisovlgnk8Edp/lMHYEtY448eiNbkresbYJRvM+mVJ6EERAhv4yVjwbONf+Y2c6gHMnDq@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKzb8er4E+yayL1PZiu+6Z7bcuuUHGLlE0Ks+Kv0pjjt+nNqe
	TGTZdkHw+lN+b4c/bthlA3XIYd2789HO/O2Sya6O/yXFkuyDKFyJ2BnS/aaSIVQq3OyqZrFuhT1
	7qRlFw46yCtlrqKrnHQzYWR3vNSUHJbimbi3JmFUFwBH4gUBn0qQmi6seR8/jeVntkw==
X-Gm-Gg: ASbGncunYABgNRbmJSEM/G9PUFt6iKjIBQxfeaSbbxXLcHCaVPxExFNGrWOFdL4ORZr
	H5KnW74kSZ2WqaXfIgFDFC7HwXAvgvDQ/mBHB+jaElGAwwuQ+KCjpd159L641oEuapFilZ2N1DA
	NKImtZGea+7bKUZb+79qjn4e/CawTtF2bhTOA5VXxrytCj9ALyjWc+LCTC14GTxkN6McH5WPLW8
	CQk7+Rux/jJZVFzOPEP/doP1VrCyTKxs/lDk1FhhUNpVxVjSNfvLQDG1uYmTqHrZp4ADhRqTPa/
	fkycVycvza303LNG7lHmvLbJOFERCscDIDquDIk8qFK4yaA6Yl7UrVGzPRo=
X-Received: by 2002:a05:6000:4284:b0:3b7:7898:6df5 with SMTP id ffacd0b85a97d-3b9172842e1mr184453f8f.14.1755018686203;
        Tue, 12 Aug 2025 10:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu8Rkwg6tXk/NOl1brWzbGx1iLmq2u9niyeF3EOyOy1kqum5BGcDYR8r3k+JuJQv8cN6B4Mg==
X-Received: by 2002:a05:6000:4284:b0:3b7:7898:6df5 with SMTP id ffacd0b85a97d-3b9172842e1mr184431f8f.14.1755018685786;
        Tue, 12 Aug 2025 10:11:25 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e1cb7deesm35097967f8f.2.2025.08.12.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:11:25 -0700 (PDT)
Date: Tue, 12 Aug 2025 19:11:24 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, ebiggers@kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 14/29] xfs: add attribute type for fs-verity
Message-ID: <radr4lpyokwvxdduurafrfu4l2uwisrbbggdt3m7afcutmezwv@tj334pmh4pgk>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-14-9e5443af0e34@kernel.org>
 <20250811115023.GD8969@lst.de>
 <je3ryqpl3dyryplaxt6a5h6vtvsa2tpemfzraofultyfccr4a4@mftein7jfwmt>
 <20250812074415.GD18413@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812074415.GD18413@lst.de>

On 2025-08-12 09:44:15, Christoph Hellwig wrote:
> On Mon, Aug 11, 2025 at 09:00:29PM +0200, Andrey Albershteyn wrote:
> > Mostly because it was already implemented. But looking for benefits,
> > attr can be inode LOCAL so a bit of saved space? Also, seems like a
> > better interface than to look at a magic offset
> 
> Well, can you document the rationale somewhere?
> 

We discussed this a bit with Darrick, and it probably makes more
sense to have descriptor in data fork if fscrypt is added. As
descriptor has root hash of the tree (and on small files this is
just a file hash), and fscrypt expects merkle tree to be encrpyted
as it's hash of plaintext data.

-- 
- Andrey


