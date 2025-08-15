Return-Path: <linux-fsdevel+bounces-58041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FB4B2846E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0A6B0227F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED089257820;
	Fri, 15 Aug 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAClpBLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE302E5D2A;
	Fri, 15 Aug 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276801; cv=none; b=BfbNqUW8DBKWeH1IIoOuiuT7kJx25CoGpMTvMKMDsunKFFFxf7tyQr5MsQ9/dP9IcwBo5TXUyPB0RKADBE5vY+qUmyymAPUDtzTYoBSCGOZTILbqitgGV8oIYKmhc6cY9g8v+uINQ3Bd9C/RcS/iQ7TrebmEdUH8085b9AWzC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276801; c=relaxed/simple;
	bh=ncsZMcaEaRyKrG7bCrmhKqxgcGm35QtHCgV+5Alx7ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6UQHgHIg9HayVJkIk9tw/8EVG6zKFw1Fcl1iY1MhQmPAtNqUoA/vph/oR8708FamWVPsiHQS1lnAe1An9bdoD9MhfmaemL0pCpY3FX9UJEhizNxHUQLvzSXcsfDUSc5uZOGq98+idZZOfwIbBSavaZAHG7WV6hdRpRvSecujB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAClpBLc; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381e0a227so1536369a34.0;
        Fri, 15 Aug 2025 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276799; x=1755881599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1YfSXIbwb8SN2s4kprGpkOdh2b7v2KrGx+xJwdVO5E=;
        b=dAClpBLcYa4tzwsNFpw/fEJgFQBIzcnTEpibvytbj1c4YO4hpLHebu0duiBT2c9b70
         23d31tl7t0vdU6dE3MoKe4SsRgOPKVrxGVOE7Ln9hqdspHec7cKcN0d/kYOxCI9K+PlZ
         q1MP292YOBL0GOGykAjcJNYdTiWLoUob+clzY+Pyd2ZDRVjGbplZ44aRoJHWSogOeHk5
         YzaCRvOQfNUmKjtLsEfsGWtRJBjfv+I4SojMvfywZIESaIFhvRVBBbjfgQIMRutStYzI
         ACohHlasjTAETE1CfB+syoQWoTiLQe1wLUIooT5qId8qlsLjrZ9MCOQYt8lU5zYD7gNl
         wSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276799; x=1755881599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1YfSXIbwb8SN2s4kprGpkOdh2b7v2KrGx+xJwdVO5E=;
        b=plfVWbp0XZ5IKi7wOMEpF2FJXE1YP74ry3+p6alvAaUQNic2YFIm4mJHU/DhrHVAJi
         SNr/7MFJqUEk8WEwrc7KH5XHvBT6C0Uhh9Lji/XI9vVvlA8jmWdQ5Y/IaGQ0jFue/LPx
         9Tb2r0MrQfHnd46ZG/OiRw8hvAMITRsypPSi2HvjNuyDDiP33yYrfDFqngiKW6kqRvs0
         gVneNZFfmq71nqnpOI+rXBbZt45UyL2gyZNzBdw6ZGp9S2BaJvlzBW0+Hg7+28y66vaP
         MIxHauDo/u73gFFvF89ZMU8/w50D2Qsprny7hCKEWB9r832JXCuR6xwW+NNJNWbK0UDk
         tmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZc9pqHdF7q0SQziWHlf3UHplusRXUyAGjEpMtfUq4bhjl+zeNUI0xABAy3Yi7NYnUKVbk1vOVrWw1FRfpUA==@vger.kernel.org, AJvYcCV/7/MY2XWqasYHVixVi+4Y+hH7Fq2lI7VQ4riSFTmZX2ltVM29RNhzUMHv4O1VRW0E0AUG1dZzuXA=@vger.kernel.org, AJvYcCX39WZA3z00B5eaD0nRYyzqMB0UCsM5rfhqDcrnoDbAjlGd+oOPIzWjYs3zy7w+Cuao0HbGLKKc+JsvSPTN@vger.kernel.org, AJvYcCXuMMnkDMgBRO8ZbKxIy5uKQ/12Q1zM0/HwKA/9O2nxdMBWrBeTo4cEWlL3/EaWk5K/hW3BkbiAk1PR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2xxw1tdxO0abbYAh1KjQejC8DCPdYocbZGgEWAfmdfHJqaVHJ
	p9i8Ai/2eYt3FZLzkvGEuZqEfS+T8KFii3R6u6dquKO0MBIS1ZxzWpGQ
X-Gm-Gg: ASbGncu1z7sKIV4oHIOl2Mu0L+a5ghSTqYE9n0qB2jgNsU6lLA8SkH8rXftJIGovWQz
	pE0Z58D6zjFPNhUUTfCJbMua1jWK2p0sTqc8ZjV6eYdsjtEKwKsQIflRri9M8ldQaSp8xmvoKH0
	EYSXeoCpc+xw09xjjSReEz0/B5BipIwb7RAcpE0fpcehKEkYgxzc9Sjrf4d9CeMbtLU8qYz7FPu
	gnT52//Of9WIwLxNzlOCG6KlYFErRXFNVG57oKwVeZe2fSq44Ov1JoxtcJ2hBAh1SPC02dw0yzx
	us40SCmRgw6ITZgOIeZgiGARRYORRz47JpXh/u++66nkYLYmkjDuKSUYQeq/vrC75SjTBJOB+ZA
	4uLFtQpBx5yg9BbxkwI1xymbP9nhunUYN2yJe
X-Google-Smtp-Source: AGHT+IHh7gvLqat09ID5S5eotjMgSZM/1+QH28GoD8XLJ484jicmNbL1KHnEftKM0DAmNzUxwWibZg==
X-Received: by 2002:a9d:7c8a:0:b0:73e:5cb9:e576 with SMTP id 46e09a7af769-743924963b0mr1268395a34.27.1755276798837;
        Fri, 15 Aug 2025 09:53:18 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:c95b:3a76:bbcf:777c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74392073461sm377891a34.49.2025.08.15.09.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:53:18 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 15 Aug 2025 11:53:16 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, john@groves.net
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <mwnzafopjjpcgf3mznua3nphgmhdpiaato5pvojz7uz3bdw57n@zl7x2uz2hkfj>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
 <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>

On 25/08/14 04:36PM, Miklos Szeredi wrote:
> On Thu, 14 Aug 2025 at 15:36, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > I'm still hoping some common ground would benefit both interfaces.
> > Just not sure what it should be.
> 
> Something very high level:
> 
>  - allow several map formats: say a plain one with a list of extents
> and a famfs one
>  - allow several types of backing files: say regular and dax dev
>  - querying maps has a common protocol, format of maps is opaque to this
>  - maps are cached by a common facility
>  - each type of mapping has a decoder module
>  - each type of backing file has a module for handling I/O
> 
> Does this make sense?
> 
> This doesn't have to be implemented in one go, but for example
> GET_FMAP could be renamed to GET_READ_MAP with an added offset and
> size parameter.  For famfs the offset/size would be set to zero/inf.
> I'd be content with that for now.

Maybe GET_FILE_MAP or GET_FILE_IOMAP if we want to keep overloading 
the term iomap. Maps are to backing-dev for regular file systems,
and to device memory (devdax) for famfs - in all cases both read
and write (when write is allowed).

Thanks,
John


