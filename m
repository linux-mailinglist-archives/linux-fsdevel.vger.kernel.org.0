Return-Path: <linux-fsdevel+bounces-18658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C78BB10F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2761F20C1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEC415698E;
	Fri,  3 May 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F3uGIcy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA315689E;
	Fri,  3 May 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754489; cv=none; b=E7hS9FRvGQxb1K8eulQEeCyLAeVdcvyWYKNVWjXWcE/4n/SbsYSsuZQ5Adrg4mvX1Vn5Zg6MS5dPlf4a4BvGWrKM76TTa16tKbrr8QMXUIJeF06bpLE5TMxOGGPhoXzEebwKkcDORib0gb4NrY6Kor5EiCAaSOr6lbCwqbBuvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754489; c=relaxed/simple;
	bh=B1UyLJUxHu3/4rhG+wBsUK5RxLqKqYVkH//ea/Z4r44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNXLc77WqBGnpdrVilFr1WcyN+zX0kUBdlfqgHpYKMA1qkpVTniQnio64fVzwZj6UQpM73K35nN70XfALcIhBy4PEIEQO+co80FHzbwqwJZikwxfmbjtAeCqzuFlupbGAdDuL3xQjsXGWd54kjpznN0zOsTQzVqXxDrqg18Dt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F3uGIcy9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Z84RAYfT/9xy4ioE2Mpx1ruRenvb0RbYAc0UnSuXus=; b=F3uGIcy9H02yNI7SSNmjpHrNiE
	RznrjD0Nmccq62dP30bCl3YqZcz6AcRpgzMyGq2uTQtXbbDmkxe+h4UVIOf2Aw9HsnkWbW+GTryUm
	rMb6A4gHnDlc0gHg7HBjff6s2FIJ/PTp/TBdALy0yYVak7H1r2UwfruPZqVIRggS4jqj6NhnMGYab
	U9Kg/r8maUxO7GYdZ2XgNhZFS7A1uK9qLhKLMdODkC4q73v7q4iOsjtU5Tbpe2TTYx84RUm/lsLiO
	J0dJX3DmY9rQNdgpSGydrcffe3mU4lvE+bNDRL9zsAP6Mrdh4M75+8T2LAAs8F2Y18m0zXucLV6Ej
	jgGCEoGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2vyQ-0000000HG7f-0r1s;
	Fri, 03 May 2024 16:41:26 +0000
Date: Fri, 3 May 2024 09:41:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Documentation: Add initial iomap document
Message-ID: <ZjUTtuNqi9o9xgwg@infradead.org>
References: <17e84cbae600898269e9ad35046ce6dc929036ae.1714744795.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e84cbae600898269e9ad35046ce6dc929036ae.1714744795.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +i.e. at a high level how iomap does write iter is [1]::
> +	user IO
> +	  loop for file IO range
> +	    loop for each mapped extent
> +	      if (buffered) {
> +		loop for each page/folio {
> +		  instantiate page cache
> +		  copy data to/from page cache
> +		  update page cache state
> +		}
> +	      } else { /* direct IO */
> +		loop for each bio {
> +		  pack user pages into bio
> +		  submit bio
> +		}
> +	      }
> +	    }
> +	  }

This would probably be easier to follow (and match the actual code)
with two separate flows for buffered vs direct I/O.

The loop for each bio in direct I/O is also not wrong, but maybe a 
bit confusing as we really map over a pinned memory range.  The code
just has a little optimization to directly place that into a bio.

> +Guideline for filesystem conversion to iomap
> +=============================================

Maybe split this into a separate file?


