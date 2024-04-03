Return-Path: <linux-fsdevel+bounces-16072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC948978ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACCA1F2855E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A2155301;
	Wed,  3 Apr 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daF348jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D31D54B;
	Wed,  3 Apr 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172102; cv=none; b=sNJ5IIOcASOElpbQPpXOSwDJ7aHmLepmudENfHQAfz++5lZs5fRej5RAAWRMlpYl5kfFmTeYakmzC68orfRv7Ffp+YuAFIXNFtrZHC9fLf0tvSadGe7C/pePci0vrTvMJWeX7szDlwb9LWuyFRH+1VYYzGrDZ+w7tWOP+gwX3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172102; c=relaxed/simple;
	bh=FT1fbad1bza7YjyFyg9rJscq3rr7vUNVyBiRRdR2aNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDGq+k7+HmbRu7HZH/AmiezRS/1Ndgg6OyymDUMqVnmeIK0iT4wM2JGOU5MDYb9GZc5Z6i/3p2hEKviEFMqaRVEzrf+Gr5AqVosOYmy5updVmcg24HXQsVsNSLQ2bObKD8rvl3l113iUqKOu1wgseBFdzCUG5mS4Jq2zMZrXKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daF348jd; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a480985625so165824eaf.0;
        Wed, 03 Apr 2024 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712172100; x=1712776900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71eP4QlMczx2Y4yJ5dvBU+fua5ttQveVgsrybppYBU4=;
        b=daF348jdUZFfbPB4Q8yX3Ebv1pNgRAV6RBOUAxcqzjgMVoMJcd7p8TYgN1kdrGz/D/
         m1aNnjUkFNEfUnbT3RnIh56RJU8evSOlDTzhWegA0lLz7VgVkIsvTjnXTz2lpl8ioJF/
         iytjyIZ7rYiP802fEcQtCYxWKAKa9WIOavUWUnQhzv5+bis2sfV1EmS04BXNZkIBy++f
         7DUx63P5J2zjiFYVJFvPQjMp22yb2FDlBqCYa5rSUp/ACPuJLKCGcNQBSFAugv/eqUUL
         lKwfiiFNzFTb/5HluEE3Qy9gqMUvohkXXdxxaIDibRNQvXxCSL17kH0Oz/c6vsz9OGae
         QC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712172100; x=1712776900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71eP4QlMczx2Y4yJ5dvBU+fua5ttQveVgsrybppYBU4=;
        b=H9ELw6clOHUWrgSxeVuWqAcsCUHFo/Cbih0WW8MbB94CaxUFSXpK7NB65fZcRyyR7j
         b8qdm0f0GVGTbMb1Vh7+T2D33Xa9bcFTn8m1Bjz6kE3sG8cwrUtLMIH7UyaieB2qmWWR
         PxVZUxThm6DwBtiImHL+ceatv3CGgnE1GuyIsNXcG7rWTKY/HKqkIbASjg50OWPmUyle
         E3ETI/xHB3GFj1AnKWhgiR4D2yeHSqk9eoXcely+OF7SvYCGXZqMVY7WsCRiesSdK4W1
         PzXT01k32PnsE4SnVnRhdayvDuuWH+ynpLzzIq9ZkfAe77Zdcj7KRNT6RP4FXvK+6DX9
         pqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV80zxeTN0upq7/QO56jgBM3JS0AR+ylDAJsZ/m/a+FveCzP0s1fdw0kbP0h0wdIHfoVteawXejOzmNpA4alEhbno0ZTahPvQRg7Dna/ZapBi6EAAF4v+1WUDO9w5pS+3qWfLepYJJndwLDCA==
X-Gm-Message-State: AOJu0YzLdFUdwtzKpnE6c1HQEkb8wEVtsA/oLkH4q3R+T3uf7+snUfHw
	Hz8Ny+pM0r5wyPVqRcnZv+n8y3W1ly8FYyZgYfUin6ivA53he67no0A8EC66
X-Google-Smtp-Source: AGHT+IEe45VMj3vsXzq43ZjMpWFWOEnem3jMe583txSo/lZHOb7SmqUEVgxDZIs/8Im/4WJlUGV84Q==
X-Received: by 2002:a05:6870:238e:b0:22e:9e53:3fd2 with SMTP id e14-20020a056870238e00b0022e9e533fd2mr300149oap.28.1712172099688;
        Wed, 03 Apr 2024 12:21:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b006e567c81d14sm12115035pff.43.2024.04.03.12.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 12:21:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 09:21:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
	akpm@linux-foundation.org, willy@infradead.org, bfoster@redhat.com,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <Zg2sQTIDom21q4i9@slm.duckdns.org>
References: <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
 <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
 <qv3vv6355aw5fkzw5yvuwlnyceypcsfl5kkcrvlipxwfl3nuyg@7cqwaqpxn64t>
 <ZgXXKaZlmOWC-3mn@slm.duckdns.org>
 <20240403162716.icjbicvtbleiymjy@quack3>
 <Zg2jdcochRXNdDZX@slm.duckdns.org>
 <qemects2mglzjdig7y5uufhoqdhoccwlrwrtfhe4jy6gbadj6n@dnnbzymtxpyj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qemects2mglzjdig7y5uufhoqdhoccwlrwrtfhe4jy6gbadj6n@dnnbzymtxpyj>

Hello,

On Wed, Apr 03, 2024 at 03:06:56PM -0400, Kent Overstreet wrote:
...
> That's how it should be if you just make a point of making your internal
> state easy to view and introspect, but when I'm debugging issues that
> run into the wider block layer, or memory reclaim, we often hit a wall.

Try drgn:

  https://drgn.readthedocs.io/en/latest/

I've been adding drgn scripts under tools/ directory for introspection.
They're easy to write, deploy and ask users to run.

> Writeback throttling was buggy for _months_, no visibility or
> introspection or concerns for debugging, and that's a small chunk of
> code. io_uring - had to disable it. I _still_ have people bringing
> issues to me that are clearly memory reclaim related but I don't have
> the tools.
> 
> It's not like any of this code exports much in the way of useful
> tracepoints either, but tracepoints often just aren't what you want;
> what you want just to be able to see internal state (_without_ having to
> use a debugger, because that's completely impractical outside highly
> controlled environments) - and tracing is also never the first thing you
> want to reach for when you have a user asking you "hey, this thing went
> wonky, what's it doing?" - tracing automatically turns it into a multi
> step process of decide what you want to look at, run the workload more
> to collect data, iterate.
> 
> Think more about "what would make code easier to debug" and less about
> "how do I shove this round peg through the square tracing/BPF slot".
> There's _way_ more we could be doing that would just make our lives
> easier.

Maybe it'd help classifying visibility into the the following categories:

1. Current state introspection.
2. Dynamic behavior tracing.
3. Accumluative behavior profiling.

drgn is great for #1. Tracing and BPF stuff is great for #2 especially when
things get complicated. #3 is the trickest. Static stuff is useful in a lot
of cases but BPF can also be useful in other cases.

I agree that it's all about using the right tool for the problem.

-- 
tejun

