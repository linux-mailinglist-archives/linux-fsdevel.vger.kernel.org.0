Return-Path: <linux-fsdevel+bounces-25204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDD949CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 02:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3071F241FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F75B661;
	Wed,  7 Aug 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHU9nYAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEB53209;
	Wed,  7 Aug 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990088; cv=none; b=TZMh8cGKFBFfiDLbRrCpT1tiY2BfCtL8vT5Id1HMDw/ZQsGnbRpFupDQlYEsS0Bv4UhT6X9oQ0ch/aqnGbaO5ufpPgzlvE5wUrD+xVXV1tIBIUCBmqub+B75ypKoBBYXOuW3fgoQCySYJEvYNtJQvW5ztrBeuBpLTkcFQiNtH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990088; c=relaxed/simple;
	bh=VLl7jO5QZynbd569FwSHqYtpf4rZQOLJzqazQOkPLMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8m5iUh4Z3iCJn1zysQnD6WRdZxs5cHO2nmc3cXeaSYbNV2lvXa3tVSAoqdSLB/SWNfJRdXnL3dsJlb5D98Zouvl53hk5bFlIc4xkr1MO/7NIjnJtOoj9aL5Wq8UbETGzcJD0oAs6nGPGTbzzdUEQwNLo5keVmCgioX9Fp48kPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHU9nYAD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso103195966b.0;
        Tue, 06 Aug 2024 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722990085; x=1723594885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i88yoTLIDPocHr7ijmBBOqmuhyxFaP0+zXgFd6KxUpk=;
        b=gHU9nYADZf5tyRHths6Go5PQcRiDNI5jkcyCZb34wnUGnY0U7v7vpH4FthkTWAp1N6
         St8MOVzl6REaIuIH05By4vNImCV+qfueQGDVyddylrS1v/bTLIKcUhVJirdGYfL6bWPg
         4SL4eWj8u/oP7qawqEE8aEPpcZF0inrN7zg8SXZMkVwww7sC0RjnrWAOkRmWbLxy+sIE
         1iGoF8RUjY/fGfLnQdDhMlO8KeU9dwI9UzdHWyeA6xldMZae31SBIdu6aAP5cPuDLzCO
         +Q0CDKh255ySDWr5KjQ70vm02/5q3QIEXaFd4h7hyuCno7YHCyTO2fkMMshv2KOuoZVV
         Aedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990085; x=1723594885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i88yoTLIDPocHr7ijmBBOqmuhyxFaP0+zXgFd6KxUpk=;
        b=M+c6AnEGIlPxEZnZcWK2I++LjfcY9Xb1OQ3NGEQ5GszyYCPGgo41ymKHhaPcHjrMLB
         Vj8bPKLdrgUW42QXc6U0XWX+IKslbfs5pGvRrRxSRA+/OVz9weP56P03p9/oxiRbB/AG
         pgjrKsTMyelYPi4S1BtOckGcT2lW1RRgeoggZujWV04vFCVQ2KprbW7B89Jn+YQ8boiW
         05bemYwymWd2sf6BXtj7UvShWHW/snKxt/fgHhgcnLwFOJd9pG/FqjP/4VVEmW3kCGIU
         u0uYbRPzAOC96qBEUaaE0DEenZkcEgQycn/cYgputl+fEbd7UUhaFyY+PlYjz0C25Rju
         NGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl/R01LAuMvQk8ekwkZbFteVc/5NSoyLLav6BbR6ugHUzR+4e7Yevs4yyQvjkAsY9l1zfESyDZ8Ui37dPPwo/Kj2d7jkOw63bDl7COC7C5H/iMPk+TWEEr2f+6tjiWVuIrab1aLGlGP/G2kw==
X-Gm-Message-State: AOJu0YxiTdvbT5i1ZgK/esBUWdQRtB1CsJ6pkvXAHe/Ny40QnsQ+BQvS
	mGJBvwFb9o4Vud5QZlfJWcKCBQ6lBtboDfWtHGDEfY7PSAOGozci4nZQrlQOkjjJwZSuR+PTWo/
	Jv8In93AYRDvggPyDVj4gGSCTzIQ=
X-Google-Smtp-Source: AGHT+IHoB2sgzoSn4obr0MJx/D4HgWlibNSFiepme53xwQGCVvHMPjhzlXn3m3hoxDyQx5WBYEwlwjfbKMGoKjb3kqE=
X-Received: by 2002:a17:906:7303:b0:a7a:b4bd:d0eb with SMTP id
 a640c23a62f3a-a7dc4e8764cmr1230993166b.24.1722990084958; Tue, 06 Aug 2024
 17:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805100109.14367-1-rgbi3307@gmail.com> <2024080635-neglector-isotope-ea98@gregkh>
 <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com> <2024080615-ointment-undertone-9a8e@gregkh>
In-Reply-To: <2024080615-ointment-undertone-9a8e@gregkh>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 7 Aug 2024 09:21:12 +0900
Message-ID: <CAHOvCC7OLfXSN-dExxSFrPACj3sd09TAgrjT1eC96idKirrVJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear, Greg Kroah-Hartman

The representative data structures currently implemented in the Linux
kernel are as follows.

Linked List (include/linux/list.h)
Hash List (include/linux/hash.h, hashtable.h)
Red-Black Tree (lib/rbtree.c)
XArray (lib/xarray.c)
Maple Tree (lib/maple_tree.c)

They have their own characteristics and pros and cons.

Linked List: O(n)
Hash List: O(1) + O(n)
Red-Black Tree: O(log2(n)): child is 2: Rotation required to maintain
left-right balance
XArray: O(logm(n)): child is m: If the index is not dense, there is
memory waste.
Maple Tree: O(logm(n)): child is m: The structure for trees is large
and complex.

Since Linked List and Hash List are linear structures, the search time
increases as n increases.
Red-Black Trees are suitable for indices in the thousands range, as
the tree becomes deeper as n gets too large.
XArray is suitable for managing IDs and IDRs that are densely packed
with tens of thousands of indices.
Maple Tree is suitable for large indexes, but the algorithm for
managing the tree is too complex.

The Hash Tree I implemented manages the Tree with the characteristic
of a hash that is accessed in O(1).
Even if the tree gets deeper, the search time does not increase.
There is no rotation cost because the tree is kept balanced by hash key.
The algorithm for managing the tree is simple.

Performance comparison when the number of indexes(nr) is 1M stored:
The numeric unit is cycles as calculated by get_cycles().

Performance  store    find    erase
---------------------------------------------
XArray            4          6        14

Maple Tree     7          8        23

Hash Tree      5          3        12
---------------------------------------------

Please check again considering the above.

On Tue, 6 Aug 2024 at 16:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 06, 2024 at 04:32:22PM +0900, JaeJoon Jung wrote:
> > Since I've been working on something called a new Hash Table, it may
> > not be needed in the kernel right now.
>
> We don't review, or accept, changes that are not actually needed in the
> kernel tree as that would be a huge waste of reviewer time and energy
> for no actual benefit.
>
> sorry,
>
> greg k-h

