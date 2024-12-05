Return-Path: <linux-fsdevel+bounces-36538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7149E580A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C9728BA46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67F219A8A;
	Thu,  5 Dec 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v93wFxX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBC219A68;
	Thu,  5 Dec 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407196; cv=none; b=g2wxT2IcCnd8OtJrNfWJQOE4eetbAk5loa2ceJ6uAHSso00e+qU+Ph2BWQkvTtd6ENEIZylFp/kbxhtfHQA6cNyo7BsZ/VN9cNcenPjhRgK9RuJsEoe925yH7RySRneIcHtyB9/xTYUtAfNv0HiFMuuLU0vrYgLfITt30MJMd68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407196; c=relaxed/simple;
	bh=EK7+Gk/puB8knUZc0RO/mSVit81qD/uGcgMxS6w5vWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPZDcGnyOu1/WEcTCQ+EsM6iXTobeidFfJhllheqpuuPG08BcE4RKFmBvE/9eS6RUKb9NkAbbgsJX4YcoasLaSkRDwoPiTgknvcfJxuj7J1SKB7szRPYLFaE7pQnjOFBsqISAl/IFnj8SeUk1/BmTTlqyaL8axSaf3K1z/6smRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v93wFxX5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=35cFPiCKnS62Ak09FhhAr0rQebrbhrtYntLRrr3P2P4=; b=v93wFxX56OCxO/MT6f7xU2QTXp
	IBXjDOOEL9WUZLnXqFYPWBbgBkVv0ai7vYi63lyEvxIyZ+wOuQe5qdpuogOi3Urm6nbs+vwIyodaC
	4rcl6JcKTEAZbqzvLNHRjNSB6hdPAVnpi/b7MWCMoj77ezvSfF2nTKc880Hl2NczI4Oa2f3PVdkMj
	+/CPG+S0592rbEHNSzeAt3tpMSrgfXoLTrFJV5sqhSHMpMrGg8obWKCeMl6XA+CveijxcwtTFxTTo
	S2hhipnrV1R8/FRo8V+zfbxmLpuOatZ/JMRgEmozMv4FM01ZXfwZ5OpLqH7BIBDYMDk0NwIGmGDYC
	yXNODRnA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCOK-0000000D7Em-3nke;
	Thu, 05 Dec 2024 13:59:40 +0000
Date: Thu, 5 Dec 2024 13:59:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (REPOST)] hfs: don't use BUG() when we can continue
Message-ID: <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>

On Thu, Dec 05, 2024 at 10:45:11PM +0900, Tetsuo Handa wrote:
> syzkaller can mount crafted filesystem images.
> Don't crash the kernel when we can continue.

The one in hfs_test_inode() makes sense, but we should never get to
hfs_release_folio() or hfs_write_inode() with a bad inode, even with a
corrupted fs.  Right?

> +++ b/fs/hfs/inode.c
> @@ -81,7 +81,7 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
>  		tree = HFS_SB(sb)->cat_tree;
>  		break;
>  	default:
> -		BUG();
> +		pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
>  		return false;
>  	}
>  
> @@ -305,7 +305,7 @@ static int hfs_test_inode(struct inode *inode, void *data)
>  	case HFS_CDR_FIL:
>  		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
>  	default:
> -		BUG();
> +		pr_warn("unexpected type %u at %s()\n", rec->type, __func__);
>  		return 1;
>  	}
>  }
> @@ -441,7 +441,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
>  			return 0;
>  		default:
> -			BUG();
> +			pr_warn("unexpected inode %lu at %s()\n", inode->i_ino, __func__);
>  			return -EIO;
>  		}
>  	}
> -- 
> 2.47.0
> 
> 

