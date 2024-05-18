Return-Path: <linux-fsdevel+bounces-19714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35B8C919C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CBA1F21EA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0844C7B;
	Sat, 18 May 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NnFE5aUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A86AD7
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716048246; cv=none; b=ZdAUO/azPMbhgtz2ksKke3SabvNuD/f4EwRfusqNOwkiXp8NAPB/m8drkAY4LlFa6W+xER4atq68YznLmH/Z7W2DxYF+hWh4b/TKB+rJfTCJQxdPHcpr25Ev4l25UpXWsig73iZbOt6KNKpmAg5vQRwz6IfBeqsl+gG806fwhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716048246; c=relaxed/simple;
	bh=sdPZlTrMpKd5RBdiT5A3YpoFv8oJpNHx4WvhcPbtetc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpLHklE7hRKu4q/6KReOWw+LRCrsYyy2nfovYzqurBEd++sebjLfA5XJVfx8TtFz3godaXzseoglgtYl6y0yfSfJLmWgIBH35GwtNiJ33ME5fQmp0YKHqtxumLKUw/vuI4/h1H0qWNoOWZuYNlXO7nyxlJEWxQC/PpHaEtUVr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NnFE5aUi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so4708816a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2024 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716048243; x=1716653043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bja8TUJ/IH7hcTFRn8iIOtWUsJ2yx+Ps2lUDd47zm7I=;
        b=NnFE5aUi6IxSwXT4Agf549RoUt6cEn+0a03YrJpupOkgUgPnKiLZZJaWrvR/wlbHuT
         mgjXyhB9cYPECdHegmn3LnygoTSFtCqm4s0KhB53dWp4grLQmRsFkSHHD+M/ea5vwPaA
         T/1lbXloO/v8uhWqEXzqtfudMB6lGNm0UtHMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716048243; x=1716653043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bja8TUJ/IH7hcTFRn8iIOtWUsJ2yx+Ps2lUDd47zm7I=;
        b=ENTjfM9mvqiseLzRIjadb23/sMSeDOBoND5WyrcdRtB8xm1DNVPVD+lcI56BmEaun8
         YRyjSFrIer4euxo6LOLZPbiHjMInChrurtiiyb0IsLC0Qb5sTQT2DTdvVyIQ924Udwd1
         xuRCkZaYnp99Z5FL06UB52aBd2lLhHVjlq1bgQj9KctHXxeZJQsKCK5EIboy7xnZ1VjT
         JVVqkJP154pid0zNEDzCQ1HLEB+0bQIMKEKbSpL7UEglH3fDgnyv7LO3VH+ZMjK65VS2
         v+g8P7LwLKmjuw4uOFvjknK46YLmnmGc99W60A5mF4dBDFFJ7/EANSGFx0DWOz9aOOJD
         tpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeVepgtHPwFDecFfkT4vsxhRz8FSYVRWB/ib73n8WIMsUIFASr7s5pfQxnrJrGrBTtps8LKLEc6WBhjVjocBWfBHCLAIgAi/gHyvZtkQ==
X-Gm-Message-State: AOJu0YyirEF6OpOqbgHOsxo7JpmaTpOl5O9ywQJB09o1jKh64uP/euKc
	kctlxL37YZoQIym7RhfDQsF4Ted4qROKGO42/UCzX6MmH/x2tSJxJhHwCmGZvysUModKQ+eWBSM
	HjdZJbw==
X-Google-Smtp-Source: AGHT+IEkacuyEU8DQTr9xHWBGXOoeNdK4jnVUuiJRIb/vyr2O073K7KHGPoxfuqVrctFiKlnrHMgIA==
X-Received: by 2002:a17:907:36cd:b0:a5a:1a:b0e6 with SMTP id a640c23a62f3a-a5a2d53b98dmr3296205466b.9.1716048242644;
        Sat, 18 May 2024 09:04:02 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd7asm1251073166b.10.2024.05.18.09.04.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 09:04:02 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso528731766b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2024 09:04:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2yi1l4QMYwvjfxRPUfD9mK12ZaZJ+ulscrbbTUB+whGljRB3Is6a5fBlSt3k4FvZaJTxeNOWwMMsPI98OL8hHBA8rPhSPGoSonb2WwQ==
X-Received: by 2002:a17:907:3601:b0:a52:6159:5064 with SMTP id
 a640c23a62f3a-a5a2d65ecffmr2903561466b.52.1716048241811; Sat, 18 May 2024
 09:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org> <Zkg7OCSYJ7rzv6_D@casper.infradead.org>
In-Reply-To: <Zkg7OCSYJ7rzv6_D@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 May 2024 09:03:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgUoZE3jq7Ynm=LtavYK6yZMboogwWtm1fGT1yqh7NoQ@mail.gmail.com>
Message-ID: <CAHk-=wjgUoZE3jq7Ynm=LtavYK6yZMboogwWtm1fGT1yqh7NoQ@mail.gmail.com>
Subject: Re: [PATCH] fs: switch timespec64 fields in inode to discrete integers
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 22:23, Matthew Wilcox <willy@infradead.org> wrote:
>
> Smaller is always better, but for a meaningful improvement, we'd want
> to see more.

I think one of the more interesting metrics for inodes is actually not
necessarily size per se, but cache footprint.

A *lot* of the inode is never actually touched in normal operation.
Inodes have all these fields that are only used for certain types, or
perhaps only for IO.

So inodes are big, but more important than shrinking them is likely to
try to make them dense in the cache for normal operations (ie
open/close/stat in particular). They cache very well, and actual
memory use - while still somewhat relevant - is less relevant than
cache misses.

             Linus

