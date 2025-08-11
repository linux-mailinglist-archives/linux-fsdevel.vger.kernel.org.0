Return-Path: <linux-fsdevel+bounces-57426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3EB21516
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA4C3A8844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209082D6E5D;
	Mon, 11 Aug 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6bs1QgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F94284B25
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939169; cv=none; b=i/CczZDUq81YfTOdfj/ukO/8dVEWIp3120xM/U+tT0MjMKO68W2Tq0frwgN49DP14UjSjyDXAjsrbkifPhk1WQyE5YtEgxNxeqCj6CEQZVKcb/bzYhOwaVTrVgxZ+AeWI4hB38LQIrWUWSxy+xarpjjUkRfSGqrwEZZYMreY+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939169; c=relaxed/simple;
	bh=1Eh6AfaqADOLJGJXwjA9U3lQXOkdRiv6lgOQOZnuybo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSwjncfV7QDz8i/LlcB/qvDJJlX0nAoQ/p0u++Oo4tSGNOrY0cotDmLO6bwjve2AmDvzi78qEsVrhfjFcTRNzK4C32rBEQilyDEyjfh9+5WfhQQ+4++CQMwcz5tXA4HQSjM1BoYOtmN6Y86dSk4cL/QnO/zL9N6qUdMz+abhfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6bs1QgU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754939166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0jNbqiZoXF2tqZs49Auc8aumYER/PfldpxEEm7lIrE=;
	b=a6bs1QgUJOGhLYP+nV0MKTprywP6bOh86CXr6+/zdsr/YdjPIjyTmrdv0sLKofvSGPTv95
	sopZQbCjGQtp6uDSso93R8Awokmtkvmy8JlvD+DLPZE6A1uRznTX9HcxreJfikZPq0tTLj
	ffBEk4Ir7zaGQ27li9yvbyYpBc7kdmQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-KSXXHcrVOJK77-9JNnwoFg-1; Mon, 11 Aug 2025 15:06:05 -0400
X-MC-Unique: KSXXHcrVOJK77-9JNnwoFg-1
X-Mimecast-MFC-AGG-ID: KSXXHcrVOJK77-9JNnwoFg_1754939164
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b79629bd88so2019548f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 12:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939164; x=1755543964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0jNbqiZoXF2tqZs49Auc8aumYER/PfldpxEEm7lIrE=;
        b=q3DXgyxzRQcOWwOOZj0M8O1ORgiceZQFCCrDHYylhvjybAZj/vSAWrr7dvcRGr/+yf
         aFmDgTmWUVc8mNKMSmqxKia4Yv8yxcmL1WW+Rcg1PaqRvLBiXbhJhhAXnnEd3hX89yqm
         YIFT7hpxxWwuOcDVScd5ZvlFnr8B1GerbaRCH3aCIyNGuETdTfIYEbzTlrRtoKwtFY4W
         IKoNIjvUZk/dWszUbo+o+fwW/0ouYHW84y4pFzw5Nqcegs6mwxwEu40ruGzA58/q4jAl
         v7dPdQ6cMxky4KjYu7o/FVTZvwNqRUk7bv6vdkujoB+kktRtPYrhoGTC7PzDFJKoWfpA
         EgKA==
X-Forwarded-Encrypted: i=1; AJvYcCVXsEuryPHsV4NqsnSg7OIMpJzr4Mv40t039Od77bqi0TPQdQFKXVE8F8J87IKEAN7AJKqphIP54NQwJ8GF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4V05a5hwtiVRgBtfMBtEfBSXR5U5XPadNawpApm1cJLFPDov
	Hsl3UFFxu0eLTLD7KJw1PQt/YKWSn97bBuU68uWWNz8RXm71Nx5tW/I6smezliaHsap5oQqtlTG
	Tsotas+LFdXd7HY4XQh7f6GJJwq4/8iDuaRFoXDa1jFh7lr7E+QVeB1sKCXTTbTr9wA==
X-Gm-Gg: ASbGnctzoNAsgn/QYBlMeiSUuCytTuCCPzOvFF0CUa6yXUxBPJCFhzR+DUTiRh7912H
	kVsiSZT8tW+NwfZgGLE248kIVS6GD5GeGeNoqLXWIxjj6u5/to0WGhaAFiGsGQcaexzHMMqTDth
	oaiTMyfhi6RwvPrxpVKj7xeDmvHQ/gNZBB51odTxUqMLWPW8xokbVO3Bne709nUdCRJASm9TuWW
	sCcTjPFwT+TNWM4ZZzfDCylU+a1kiXV4vBmAwF6BEOuguOrxQ1CRQZ8T7HPF5kYNtA+Q87HCqwH
	NuyglkGusGo5j+SL9rNjuXALz9SL9BXSYr8D+FQ1EBGxYkLE64HxgXMQm/8=
X-Received: by 2002:a05:6000:26cd:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b910fdb7b4mr751813f8f.3.1754939163920;
        Mon, 11 Aug 2025 12:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvt+eTJyu4t855O5qiCAOPraEsgDNT9X12Nh+utFT63/nKwS5zbJvlreALiUXMuzbjfYxWJA==
X-Received: by 2002:a05:6000:26cd:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b910fdb7b4mr751800f8f.3.1754939163533;
        Mon, 11 Aug 2025 12:06:03 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm40405921f8f.32.2025.08.11.12.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:06:03 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:06:02 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, david@fromorbit.com, 
	ebiggers@kernel.org
Subject: Re: [PATCH RFC 12/29] fsverity: expose merkle tree geometry to
 callers
Message-ID: <smswj23kbrrku7q4spkqyfudzynbyh6cgi5ro5vrmo2hin7q22@5ege2lpzd2wh>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-12-9e5443af0e34@kernel.org>
 <20250811114813.GC8969@lst.de>
 <20250811153822.GK7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811153822.GK7965@frogsfrogsfrogs>

On 2025-08-11 08:38:22, Darrick J. Wong wrote:
> On Mon, Aug 11, 2025 at 01:48:13PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 28, 2025 at 10:30:16PM +0200, Andrey Albershteyn wrote:
> > > From: "Darrick J. Wong" <djwong@kernel.org>
> > > 
> > > Create a function that will return selected information about the
> > > geometry of the merkle tree.  Online fsck for XFS will need this piece
> > > to perform basic checks of the merkle tree.
> > 
> > Just curious, why does xfs need this, but the existing file systems
> > don't?  That would be some good background information for the commit
> > message.
> 
> Hrmmm... the last time I sent this RFC, online fsck used it to check the
> validity of the merkle tree xattrs.
> 
> I think you could also use it to locate the merkle tree at the highest
> possible offset in the data fork, though IIRC Andrey decided to pin it
> at 1<<53.

I also use it in a few places to get tree_size which used to adjust
the read size (xfs_fsverity_adjust_read and
iomap_fsverity_tree_end_align).

> 
> (I think ext4 just opencodes the logic everywhere...)
> 
> > > +	if (!IS_VERITY(inode))
> > > +		return -ENODATA;
> > > +
> > > +	error = ensure_verity_info(inode);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	vi = inode->i_verity_info;
> > 
> > Wouldn't it be a better interface to return the verity_ino from
> > ensure_verity_info (NULL for !IS_VERITY, ERR_PTR for real error)
> > and then just look at the fields directly?
> 
> They're private to fsverity_private.h.
> 
> --D
> 

-- 
- Andrey


