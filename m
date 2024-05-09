Return-Path: <linux-fsdevel+bounces-19205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561438C13A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8ECD1F21D82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E54134B6;
	Thu,  9 May 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jfTDpJk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B310A39
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274941; cv=none; b=Q8vtn4f8b/KnBq+4qF0ZBDLky9NxSeuK9zgulAnL6X+MPduygT1ZZ0h/lPeJIreIr9cdMQ1anORWmYmPStWBIA5RXmO1NqG+kr82TuZ4JaZRwJ6ojnhS7FMZlTbsZGyQKnwI4GxmcWyz9fxXe5sQLH9QM+fOXMqw5TOBCl15TEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274941; c=relaxed/simple;
	bh=I2b3mZDphqAOw1CzA9XXn8owOPYBXLxuDEHOZbykNDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xpmub8P2vKEgWs5gSvSTdGQiILIrpwljYFBo0Og4b4SG2J/JW7TIQJ2hcROtz6T3BuUVOqWlFCz/mPjl+JHjmClfbuIXKdC60tNyENeNuh/3cSTroDeFrr87ytpR2RJJm3qm7uql2GI0G1yZIX50RIwfJ8tkPWt2S+TBHoczr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jfTDpJk9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C5431411FC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715274931;
	bh=R13CNUyH1MbzjMY2CalRPAAS/uvh6wjQHgeABBOaJzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jfTDpJk9q6zsy8oZFwZ7HCMxbqbfLjcGbav/51M9Fm4+eTXRvos2ySsnq89ZXrNNS
	 1VcvnR7ZJHGaPw5gzygz5GDjkk5zkh4S6a+KiD+kc2SBSk5SAwd+l3mQXIF8iWDoJT
	 L2PrVEzpj9gjSd4ECS9md71qGtQzzKP+56ndq3PP6iEzNKo55xMwdwpa1EFespM9ni
	 UfBGS8uzTTJ00eCdW7Jc8j94605ezTLe6iCY10QGNheCFNZbpSHXRN1Oj5OK1Fzall
	 B+orPH+7QPrJEHyMQbg1cBVzykUyFmo5wl79+wpABZ6dwjVE9+y0U9WJrvLxI5FagB
	 aekqH4pn1IjYQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a59c3cf5f83so72962566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 10:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715274931; x=1715879731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R13CNUyH1MbzjMY2CalRPAAS/uvh6wjQHgeABBOaJzE=;
        b=oKYWjP9XCq+8P8hAcvwaIqOBgEAvts9LXpGiHwWioeBmMEtJJxZfTIeHHC9uPlvDSm
         FjwXoyPZr1R7vLxzXmVyGEcLUPAgPozvTkbl8E9oOszBWtzYB9BFg62YEHt4RQKVnGjO
         27Xzazh/zK0C8L07pAlBDSdqZc5+OtOLAnxkjd4VfBH2Ryg9Eu2tMj816WQrJCxdxnQ6
         LBR13vqf0tC+uIKoAnPABfEpTJNsINglRCF/GAxqKPV8pa+DlAv4mrzxrFwN/ksKTzWR
         AV3M9LYFBl9M19R+6+eAfAvGporkggOgFKKT5f++jkk32bL/zvB0YO6EsSySPth6CjvV
         mMVw==
X-Forwarded-Encrypted: i=1; AJvYcCUleW1wiGzKHm5gSewmik+drZKxHwEs5GetcWLEC4mpUub3dk9QAisWJZ09YRsN4EIS+DWQW/RSAPQ4AK/fLOvthFNRJMh78TT/M89TyQ==
X-Gm-Message-State: AOJu0Yx6X9xWjXThkzspdqTIXxwMBVAb21EmbqSLdHUJF+5mnFR7Lu5U
	CqLVeVhky3+J2X5b29+vv/pdslE+xdkuV26ru7FA38PQcCdP94ZKvHNUhyINCVgUVaXAC6qD51e
	aSmc87dizOA6JsEnm+xPr7DWnN6NQa+CECJfjX2gm5NPn7kTNdDHy0jIuUu1GcOlU35wNJ68//z
	SaeoQ=
X-Received: by 2002:a17:906:3849:b0:a59:b02a:90dc with SMTP id a640c23a62f3a-a5a2d66ac03mr15004066b.54.1715274930675;
        Thu, 09 May 2024 10:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRId3ZK7jZnEUqxnKrbYMBDrOXsoSZ6C8TgHiChCG3zHZRXUk/mhnLLXZdmjv+NVtyVoseaw==
X-Received: by 2002:a17:906:3849:b0:a59:b02a:90dc with SMTP id a640c23a62f3a-a5a2d66ac03mr15001366b.54.1715274929765;
        Thu, 09 May 2024 10:15:29 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm93194566b.129.2024.05.09.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:15:29 -0700 (PDT)
Date: Thu, 9 May 2024 19:15:27 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
Message-ID: <Zj0ErxVBE3DYT2Ea@gpd>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221132400.1601991-41-dhowells@redhat.com>

On Thu, Dec 21, 2023 at 01:23:35PM +0000, David Howells wrote:
> Use netfslib's read and write iteration helpers, allowing netfslib to take
> over the management of the page cache for 9p files and to manage local disk
> caching.  In particular, this eliminates write_begin, write_end, writepage
> and all mentions of struct page and struct folio from 9p.
> 
> Note that netfslib now offers the possibility of write-through caching if
> that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
> v9inode->netfs.flags in v9fs_set_netfs_context().
> 
> Note also this is untested as I can't get ganesha.nfsd to correctly parse
> the config to turn on 9p support.

It looks like this patch has introduced a regression with autopkgtest,
see: https://bugs.launchpad.net/bugs/2056461

I haven't looked at the details yet, I just did some bisecting and
apparently reverting this one seems to fix the problem.

Let me know if you want me to test something in particular or if you
already have a potential fix. Otherwise I'll take a look.

Thanks,
-Andrea

