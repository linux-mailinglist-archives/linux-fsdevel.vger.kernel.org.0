Return-Path: <linux-fsdevel+bounces-57902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B7DB269FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D43D5E8217
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2B1DB34B;
	Thu, 14 Aug 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KQNJjeAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F11E1DEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182233; cv=none; b=CM8STh/GLIuo9bfHv7TqSh4VvGJ+BrRDhEXtSB4yLfoh6tBoTNQgsnD5ciOaqfvwlFKqCA6DFI4EfHwIGNfBSsYOUDjwBoXLWSeirPgNeBmpiRLNe+53VTzYHGJ6C7uxCsyZ11ZCOPZX7fWWJ/Qy0ThRDaxJzMvfrpDGq41QocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182233; c=relaxed/simple;
	bh=NOpPaMEGwARq4CHAFNBf771d9jPnS5ZeE6rfKhlvASU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2Ykeo10mNwrmh/+gQIPLI0pDWgpj6o7QNQwBunwnae1QCfR5KGZZKYGCIa7mx3eSeovkg2HHjcIRn3HNZBChKXBW7azlmp4mcBqInbWzd9rCSk2aCfS4ijyS+M/gmZy8+zeo8Xt1pCsehT8hX9R5695kjfax4tfrjsOR2LHnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KQNJjeAf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109ad6411so11268891cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755182230; x=1755787030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thFJCyGfhvQRRqY0DjMQa3Qo17IKtZ1G40gUR9k6ews=;
        b=KQNJjeAfSoSwUDRw80154oLg3NjJYeTUwz6KXDBkYfQTu8vynYQjQRzggbRtxTurRv
         L1oI7K7IHGucMXWSh43/r5zPlnon/WpknKv47HhPAwiY1H/gITEGb+I8a/WvoKgR8SpP
         qeUdiB/FilITBvEDt1dY4jA5A58cLYBl/doa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182230; x=1755787030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thFJCyGfhvQRRqY0DjMQa3Qo17IKtZ1G40gUR9k6ews=;
        b=quYAph+VSwN+j1teaRZY4RjvJSQzVnNJu+M9Y07UB9Xxnix3obaTrlmYrSCg9gACjt
         ZMUQ9Wp23d1w9lZBpxNIa+mu2jzoHZ0wJcxcSQ1U0imxRz2rLOVNTnlzSTCWa6ncp01l
         Dh+bNms3WLDTzaDAgWT7Nku485RSKY4YgUBhHPzdsyk2cV4Cv0hFvrHipP6OFMUkFaxl
         gJcxKwfkJdeYCGZYlx4WAAjKa0l90Lw5djNAA27EhqqC7UYZX/O8T+RHroP842oUOflZ
         pJBToKpCzd13ZyOGLliGBfKeBrT5v3tIvP7O50AlXNtd4lumZsKH9fp6iHL3UOQKtbxW
         +AyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKELonTX+OuKJo2p3/Wr5xZf3JJek2BlGOGp6e3djNWaf43xyILALhb6IpD3JnZbw1xjlkNV27VnV8GBbd@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTTUeMPBdPsbv5Zgp9Flt+henw5J7Jawx3TO1JpUN3izDkzFR
	3QRo51++VofsWF73YL6GuCOQzCfPEnvao3xQ4uQnFefHNZ8iJZaaheUnsie1mGLbygxsiIu6bZj
	Sb6M1Zj7fr2v1b1AsC6dMw0dUH93w+LKRE98Xt9XLdQ==
X-Gm-Gg: ASbGncsfIoIIGEJ/PpwBaOr0+NeGF+eV5kwydCN7OvEvsPwVviM2o/coV17OqSuM8Hv
	qRfqaM/+zHBqHxZknsf2lzJOaTQnz35pd4M31zxu3w37ePcMBKlRM7B7TkZN2wSsA452rV8sEed
	JwLpAReZc8DHCdIMaCg1GRgbLNqDOd2FeHd37eO7PAkBjxEqKG9jqviKhA6ukXE3opjkwQuj+ld
	TJi
X-Google-Smtp-Source: AGHT+IHnfRI5xHzwEiwbnlj4w/zFMDDNEEaatcq1mpqAAB2GV7mMF1beVsw/Q/x3FPL39V74ikfbsx8wh3qug5aBccg=
X-Received: by 2002:a05:622a:1926:b0:4af:15e5:e84 with SMTP id
 d75a77b69052e-4b10aae7b12mr50528031cf.42.1755182230192; Thu, 14 Aug 2025
 07:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
In-Reply-To: <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 16:36:57 +0200
X-Gm-Features: Ac12FXxrfsSu-05pCnMumsCzYXADqTJ2OFTZfF8uQPidyp6kmWUcoLNSx-lr5VI
Message-ID: <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 15:36, Miklos Szeredi <miklos@szeredi.hu> wrote:

> I'm still hoping some common ground would benefit both interfaces.
> Just not sure what it should be.

Something very high level:

 - allow several map formats: say a plain one with a list of extents
and a famfs one
 - allow several types of backing files: say regular and dax dev
 - querying maps has a common protocol, format of maps is opaque to this
 - maps are cached by a common facility
 - each type of mapping has a decoder module
 - each type of backing file has a module for handling I/O

Does this make sense?

This doesn't have to be implemented in one go, but for example
GET_FMAP could be renamed to GET_READ_MAP with an added offset and
size parameter.  For famfs the offset/size would be set to zero/inf.
I'd be content with that for now.

Thanks,
Miklos

>
> Thanks,
> Miklos

