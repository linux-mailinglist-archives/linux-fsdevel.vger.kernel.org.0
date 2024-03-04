Return-Path: <linux-fsdevel+bounces-13562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6998710D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 00:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DACB21EA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9E7C6C9;
	Mon,  4 Mar 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MWIfQ8je"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB77C0A4
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593400; cv=none; b=tKkqNRTvxGFWIFQFNr9HAx+leqz2JrqrXnZ9zJcB7M441SEq9ScH3y0Ey2yugTgu2HHWRsJvHDpJO7Djb3NCuBlsRq+dftwPGLyY6Mlc+5ham51bF0cnxgMRUQK5mXAEXC9fqkiCCilo0plm8kCBcj58KWs3eqhjZMqG9bMRwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593400; c=relaxed/simple;
	bh=7WegmzHOMCbx4tuQ23wzNZFpsXhn+SpD9Xu3BPE9yV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+XrRWgx++O3qB6JhMMifDe2/sJk8EUPMnK9xAiTIINa6J1uaRmla8LvcfpYRMCZusmJnoobSqH96ed10jlz+43HGv1aGk7wJ1RXv4ZR5MRgi4HDXYFfdI590ouBrvKw0q+4jntirYa8892Q7kzn5uMHJ6Yju+ueh2L2JH4NY0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MWIfQ8je; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc418fa351so44280105ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 15:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709593398; x=1710198198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zra570GFR/pjaJOF7w0ZjlWxu8eCrPVL1ueeZxNYpzs=;
        b=MWIfQ8jeMC8v6Z+60GpM2H7Sd92e+wbzvNan9EPrvt6nuj9ttlOqjdkrhRrYgqviub
         0J68qEpVmXIjkZPMnc6ZWrjhWRhunw6/f9R0tf+fXdAfJhkshVhFgUirISaRCr/51qWy
         r99Hrza97tr+JBQFmxZgp4xAZ1gblbDL5pXdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709593398; x=1710198198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zra570GFR/pjaJOF7w0ZjlWxu8eCrPVL1ueeZxNYpzs=;
        b=a3fT4sYNcLYfutc/uQ8zh/6EzsM8dCB0P/8hxwqXiXhvH5eVf5+UXbDa2gtz3tGEX7
         X1thS5OCwDDGkQt1OeTojAdQZwC6auSehtI9xsK4LnnrjWv0jeY9stoe+hQgMgOgDrwx
         7wR2uXU7zn/LeRrCEZcrVIqp68vZu0+KSfrebKCG0b/gDQ5y4FJFASY2VID3VOG4swj7
         6r2Tibt44kFIUtmB+7mcNgp9tpzZkKz/8oyFtAJVatoEZj6JklSbwfWFzJrI9u9sg8hn
         oKcWt5t078aUsrTMMODBViPvRDFN9c5/SNwa/bwBhh5buMCHka9IdFv+w0Nf1VNilA+U
         wH+w==
X-Forwarded-Encrypted: i=1; AJvYcCVTcqXdTPLDSORVynt7VAwn3fSMrZQot8E1j1xzteCJQgJGHYp9oRA3ZZbRUDV/i18jXuZUIQUvaDQz0X3pqWenkoaFw+iZcaaSnnWXMA==
X-Gm-Message-State: AOJu0YxPpXuTF5lNKI3CQHWZ2oqfdvraTYqWp/gXJYpql6K4Ace/8mJs
	1w6KQimqrLCOqnWuvSEurOnnRIsvJu0m3sVkuQrHNrXnB3GTIw7vLrPgtsruHA==
X-Google-Smtp-Source: AGHT+IHsjDW+/7Ivd2i5nhU9uSJtEYy1nZXqKX/92Fray8kBkmWVSPGumJAavlMlS3tPeIDd5jdokQ==
X-Received: by 2002:a17:902:ec8f:b0:1dc:fc84:198 with SMTP id x15-20020a170902ec8f00b001dcfc840198mr231857plg.29.1709593398024;
        Mon, 04 Mar 2024 15:03:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001dc9422891esm9060623plg.30.2024.03.04.15.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 15:03:17 -0800 (PST)
Date: Mon, 4 Mar 2024 15:03:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4] xattr: Use dedicated slab buckets for setxattr()
Message-ID: <202403041502.28477148C0@keescook>
References: <20240304184252.work.496-kees@kernel.org>
 <20240304184933.3672759-3-keescook@chromium.org>
 <20240304221648.GA17145@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304221648.GA17145@sol.localdomain>

On Mon, Mar 04, 2024 at 02:16:48PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 10:49:31AM -0800, Kees Cook wrote:
> > xattr: Use dedicated slab buckets for setxattr()
> 
> This patch actually changes listxattr(), not setxattr().
> 
> getxattr(), setxattr(), and listxattr() all allocate a user controlled size.
> Perhaps you meant to change all three?  What is special about listxattr() (or
> setxattr() if you actually meant to change that one)?

Whoops. Yes, I did one and stopped. :P I'll fix it up in v2.

-- 
Kees Cook

