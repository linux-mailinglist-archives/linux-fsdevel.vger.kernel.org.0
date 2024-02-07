Return-Path: <linux-fsdevel+bounces-10676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A484D574
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC9DB2239F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749712EBC0;
	Wed,  7 Feb 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="N0jswrwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2A12D751
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341855; cv=none; b=QSHOF+hDSVQweyIVmR8QPWT57X64b9SiTDsJpbuyyB1T8ZuHw0THbBLtuEZnrDuxcy4kPUg1PYv0HNt2rRIaeDfNY2jyv32mwHPRSmv8sCqQrDfBGezsxctqjRb16Q8yYnDug06huQ1yBF3bmYVdIQBagVKAF4ekhl3agbZ1UWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341855; c=relaxed/simple;
	bh=MJ9tjUW3xcnRUT8N8amSJPFJmFefKIlDCMy8MipxXqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKWWUp6Pb3rcU3BCsch01d7ZkdGA6MGNGk3ruCn7YJ3F1MxQZqrRdZ/pX4t2Ezj1C+Khm4lDBZrLJGH5Y7MkmPXCnihz6khhtb47BwSBqZ9Imbp8+2Me4iC3igf97WsyfLxy5n9bF1RCLVCxrpPFTE51wK4Kc4lVUzDduBEi4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=N0jswrwx; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59927972125so654736eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 13:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707341853; x=1707946653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5t8oHdj43HvWAnm0LTgz5p/xtchmO2b+GM6B+T+0/v4=;
        b=N0jswrwxQQT4YcPXYv4ZUugehgcpncIM8mEyojEWXDGYTfFxLhgUnL7tazfQapgkqJ
         74T2Iw71qddWRpHAo6sWGUMkvP2mOnCvvYG8gc1pezE5XN00XxG4OBTSkJoAmhCKKFmp
         x1sR9T2Jb7JJsbikOujRtWMHU4Y5po5mSmX6vTC+QWLb1TsMFCQFOmnwD+0v4QvDZZaV
         FdXKwhA/IrdQUkIvpr1jNToc/7NdiqDNVD4HgMV2PYVjl5pzaPM1AUG7mhWHemXcIbKj
         i0omi5NjLLaHRYebxQbAazYAuu1RTHar2rs2/EZP/FE9xmmxuOJWv48RVsBT5x4bZXHb
         sT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341853; x=1707946653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t8oHdj43HvWAnm0LTgz5p/xtchmO2b+GM6B+T+0/v4=;
        b=ea2cKpVl27v/yCuQqs0OtkcHQYyOlVwooOm66VHIbvD1YbIvlPqWFSmET5xlnNksvX
         XzCqsrweSMznvxbdlQpWjVOZN2XnaSKbjdKzA4iqSA4Wojz7kjbD+D1ikk1LUg+RiWaD
         AHSr6Z4OogPmeFnNkDSRdpcrtIZCFCpFF+m647ZhAYxQwU9ESvloRLcPhaskP4orbZ3w
         qkjSKCy5m6/SJ2zRiKFS+wdKl/NYcQysC/rpUEEtbkkfmmsvMN/7/ILZN3FY22kv1TH+
         XEsVkUTg+00D1bR67qXGv2cm+GPUZzl7CjkAxnRW992x6GvGH8F4UKs6mFrl3U4QyPCu
         ynOg==
X-Forwarded-Encrypted: i=1; AJvYcCVKQ6AkpbfSpZHf1yhozoGqxkhyLAwp/j6bLXDTB5njedI2jVTYLzsrjWipOiNNhej296L+SrsqDlmZCyVUqiLFO9bdzr/j9JqeAGFwoA==
X-Gm-Message-State: AOJu0YzsFvcc4LGZGaJbxIN2v4XatsMBWiEu7TPGVvdl/LbRv6mpC3lW
	W2GRdnji06LFaO2b1xqEoUK6gniWIW8Fk0OpuKN6EKJ/Rz5kjcczR2U9Tj/gWhHxENUP/5ciw49
	J
X-Google-Smtp-Source: AGHT+IHcjmtAy4moDc5eecSrPjzxgf0TzI7mCdcZJ67DZTcwDTXZZq/PsQpeSSfJ3bKSPuVgJmO5jg==
X-Received: by 2002:a05:6358:1914:b0:178:f482:6e56 with SMTP id w20-20020a056358191400b00178f4826e56mr4157938rwm.12.1707341853161;
        Wed, 07 Feb 2024 13:37:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnaI1yMTjyzyiORfE4wEG0c0EjfVS4eLq8k2NEdte69T9QU5xFLujYbaEkBr6CBLt5ZJ93jcGIqhoUtf376yA50qdtiwt1x8eFmjFbcB0wjN2SncXYHgmdh4NQbVk9Njweq8Rgg0cuC/4nRg==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id r5-20020a632b05000000b005d8e280c879sm2137667pgr.84.2024.02.07.13.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:37:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXpbl-003Rb1-23;
	Thu, 08 Feb 2024 08:37:29 +1100
Date: Thu, 8 Feb 2024 08:37:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] tracing the source of errors
Message-ID: <ZcP4GewZ9jPw5NbA@dread.disaster.area>
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>

On Wed, Feb 07, 2024 at 10:54:34AM +0100, Miklos Szeredi wrote:
> [I'm not planning to attend LSF this year, but I thought this topic
> might be of interest to those who will.]
> 
> The errno thing is really ancient and yet quite usable.  But when
> trying to find out where a particular EINVAL is coming from, that's
> often mission impossible.
> 
> Would it make sense to add infrastructure to allow tracing the source
> of errors?  E.g.
> 
> strace --errno-trace ls -l foo
> ...
> statx(AT_FDCWD, "foo", ...) = -1 ENOENT [fs/namei.c:1852]
> ...
> 
> Don't know about others, but this issue comes up quite often for me.

ftrace using the function_graph tracer will emit the return values
of the functions if you use it with the 'funcgraph-retval' option.

Seems like a solved problem?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

