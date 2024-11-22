Return-Path: <linux-fsdevel+bounces-35586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C452C9D60B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34387B25692
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E113BC2F;
	Fri, 22 Nov 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="hP/IIsis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1E2AF04
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286761; cv=none; b=r1ggVBjL41kHO2vWmZw5YspsBW+t9zKCghSZHaiALa1xC+tzYaPIOTfi4ti5aq+QmO46HnP+cxnM23IqppA7EyttOlY3NGuuhBvAgsozx/gc1L1k9dHHbcx+oe3z7kgBZ0WMHXD+UZfF1ISIMQAN7QXbQJR5H/hZsN/dccfcwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286761; c=relaxed/simple;
	bh=XKUYjqZLWWKoLbHd4kLrpcd6vdxfN45fvp6MwHupBtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJFSdEx1t3xIlA0cf0wefzclcDoarWkxSHN4LayEwFH7tzAScP4o05++je9/zW6QilheuVogu8bYwiTQczCGdhF7t1KN1JXz9nu/kVMyKvXMObnY5bhxXkVlAogPHMqk6goi/kMGCAA+QSrBKem4MjwjIoXuBgqcQwgUb1ktwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=hP/IIsis; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46098928354so14057651cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732286758; x=1732891558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbQTAWzpewdCMpMWFlTMPoUTlMfRVCWBUei/JtblS5o=;
        b=hP/IIsisUh2nkyNM/BO3lrDjIZu4E2O+TBQkxKHQMe2V09wvdDe7I58+WShAjrPHbM
         f8EN0hoiWsM9ZpKhHOjVN+8XKCxpfL+GjetJUGvMBXz3OE2l+d69SsP6uyKKZX6E/me3
         NwyGzjWUhO7JNY6Gyzp0tG/7Zm5p7L2qqF6c3U6CI4ETOdsfpnsFAEf8LSk1ELHPo3P8
         rGuJtTXHb2RaaADsD8AhyfEvH8FRYwpqQk9EBgzCp8nSSCREmfWkT0r1E6WxY45AtOUe
         mZAsHen5CN9DU/SPbfYIVsrSfNs2LzcmXbPqIoG2RwE2jvoNAExX3AZ6q1UoDSiqXsFz
         /0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732286758; x=1732891558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbQTAWzpewdCMpMWFlTMPoUTlMfRVCWBUei/JtblS5o=;
        b=nEa7c4h09k9eJyy3yDSGDhAA6Goi1XFlwCRHqG1VYBKX6Xa+YCM0BQ/obhs3L0eCu6
         zRN9W4iyS4pVEceXB6CTq6gSUptuxvZ7IgyYwwD2ZtqWcrFah80Gdm2kT7U0T7ZGfmRi
         AjAyr7kLRqdZZkDPJd/IrvpJXkz5ORVl+bh5Ah0jEcj8yrv+09YTYrS1VcgJAyPcVO88
         7fH7ef4M9rGt78UvRD/uKlv4jGCTxM7E21v/MocZG8GIi35IQzomiF/ac049k1Z6tjXy
         Ww5VxJDHWogtX41UpGKEWXozXCRj780KIVSq4VshZ0zBJPxS/ZKqoYRmFDrRa4noufFu
         vfgA==
X-Forwarded-Encrypted: i=1; AJvYcCXfzrmAlu27Ais938UE+yIJEjcEDy1cWTRCxtJtDxaej9uESGzC2Vt0cTfJOMnhWPpHY0dm1UL6z+8tvbSU@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7Uv/1VBpDyTqHpGDbAdOF0iFNiMbzQevFH+tXMdP3kew253S
	FmFImVomkupLDziu+EZIM++XO3mG/YLRgXF1FpTU70pDfKf6xqxOQlPSKNbmQoQ=
X-Gm-Gg: ASbGncua8xPM3x0gKibgC5GK8FPhV7hoHqE4q2xUgyrBWkJB3MMWGjnxCwa/DdMPuGj
	e+MiAiFNX3/wPzxgWoZFsVx8xq4707lls3spcXvO2kyFjkmPcZc2gsoGssny+28AIk+YEkKIV16
	4+O1usHvWDqeihXcQ1cR3yCPqinJBb4eHRwGg2YmFWsj773rPJmQCTjVTZeGy1ioIqCplT1rrqh
	T6Sw06htwtCMXtmB553jXQtkH/lPIJWqICMqFPb/vzDXKg54qgAPA3qOUw48pgr+2ca66Aut4sG
	6fHC6qorO3k=
X-Google-Smtp-Source: AGHT+IEDYX0uzE1vpuhzrNITKqSYqLYZPfJXe7R9A8EJtyLdRKloMVbbUVDte/nbIkRR8zy/yXHqig==
X-Received: by 2002:a05:622a:15d4:b0:461:313e:8865 with SMTP id d75a77b69052e-4653d57c4bamr39464321cf.21.1732286757947;
        Fri, 22 Nov 2024 06:45:57 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3d70fasm12127951cf.13.2024.11.22.06.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:45:57 -0800 (PST)
Date: Fri, 22 Nov 2024 09:45:56 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 08/12] fuse: support large folios for queued writes
Message-ID: <20241122144556.GD2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-9-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-9-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:54PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for queued writes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

