Return-Path: <linux-fsdevel+bounces-48010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED7CAA8904
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 20:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BADF3B8054
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA06D246797;
	Sun,  4 May 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Ee1whrGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMJ+IrZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC11D9A41
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746384058; cv=none; b=E+U/FlOeLqcgCvqUzctgTWPln5rbawebRrPZscHqfXYQi6X0D6OenuAAFO0C6UWfWL7fuq2bJaDM/fR2LAxaGURecTJ5kp7FM00DZLnD0BiL3PO53hSuqZwrdydu0vpXtGM9cI+OqGkmUdZM+gJ8coSlAyOVYB4kaY9GyVFTl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746384058; c=relaxed/simple;
	bh=A6eHRFecl88uoqKyU/Kdp/1DZUad8vYKznb8z95QxT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO4OibBjmuqioAZSuGj2w7+hJhw+jC1NYCSH8fPqPazHrOx1jgN1J+DtlzErb/sCWrK0Auwwwa5A770Nz7V/VfP5AwX7/W3KntpqaX28iSw/F9eeDeZLIVNdzR5UhR85ibtNbxNw2K2M8yYJjYorGXAnHuHk0hLUkcswtNhCwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Ee1whrGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wMJ+IrZm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 166041140172;
	Sun,  4 May 2025 14:40:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 14:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746384055;
	 x=1746470455; bh=3D2C/jqS5EPQP/NfKZNciwDgqFZRDTqvhP4vwht7Yrc=; b=
	Ee1whrGlelX0gSvXZNdlm8Ca5nqpC3ytAvkTdrVgd5BHhYvwUh7fF2opaCzCuODc
	QimaekVJTL+voc0UkhwvYhdci+wKhKownf4Dw+piT8j/cRO6dGxDrXac7WwxRZrO
	Ap875+C8OEp6ZZeF/UtngPnhgutLuo8xeXp679zqX6MQjyduX3ihfNPAmH1+5M7V
	eCqTPwuJ9gT5iXwPvhmMiwg9U/ahLnCgq4H8lzuUUKto7FXqvyRjIOp1cPM/M/0P
	bpeIgHLvzXxsm32ZEPsfVULE3bL1wpdOjVQr7FEBeMTeKonH5aqs32EigldDpLQA
	ipxh/f6+jWkP+8a5KVqwvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746384055; x=
	1746470455; bh=3D2C/jqS5EPQP/NfKZNciwDgqFZRDTqvhP4vwht7Yrc=; b=w
	MJ+IrZmVzIeBniNM4krRLy+760Wxl/ZEpgUq1Xa1Y0ufOulZWS+55Q5q+95F08vL
	aeaK4LbjfvumIe+oCB4Cm4diwWmmGQzNMpWOfuUrEaQphMjB/u86pXdaWabPRgKF
	3a48IX1zO2D9tdUiE3FpmOvSKe3JBajHQ06mUBoPpRwkRrSeyqDrfvXSHwDqf8k3
	6mG6RJ5TAd6Gabznk7YUUT24tIEi2PjSTa241Z1c/ijuzWC8ygKD/P2YG0haNrb9
	e72AJbACb4q/42ynRdPTbEAXl7pPqAG1QFyTVQt5PaaFIGXv6yWMFf92ZpOw98Et
	9d9+M0fFqs1IFk3Fktvgw==
X-ME-Sender: <xms:tbQXaP48NGwrSNpgKmkpPQ4IyUdxaFJIKYB8UvkTq5nDQwPZsoBdRg>
    <xme:tbQXaE5IKMdCFKFd4olFrWLe8e-6rFiglhT_JryR8n7Spg72IA5Yuh30d9tGP9EIy
    X82aeDeQoAzzF7W>
X-ME-Received: <xmr:tbQXaGc1ZUBMXnPeRrQd4LSFawJWcQ_7rQ-1smY60qQlDZZOIv54aTsZlAeg_X3D5r92Vj3OnI_Zm75bLr4Nf7Rqc2KzrgFPAx9obYtSz-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgt
    phgrnhgurgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:tbQXaAKz6SrnUx0r8WDQh-hTplUDbIpExG1pqphYOS20c7w3QEuAGQ>
    <xmx:tbQXaDLIcDosEW5aYCHSDxn_YNyROrQDiZ5phvCTBFEfNgxLCQcWjg>
    <xmx:tbQXaJzF4KDFYJJJelRsnZUCQYZgEdFEtRrvYvyowAuayTiI9ZxU-g>
    <xmx:tbQXaPLcq1dJnRG2gIYs_liEZpNrVC3yoEFQmWOTtYXTGw-iNTFBUg>
    <xmx:t7QXaNNHwOgV_XHgIrhqC0EklMA6PJme9HEpShaZpxLOaozfhE7ABN1K>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 14:40:52 -0400 (EDT)
Message-ID: <7056a0db-106d-4a4a-8d4a-848458bd13e0@fastmail.fm>
Date: Sun, 4 May 2025 20:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] fuse: support large folios for writethrough
 writes
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-5-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-5-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Add support for folios larger than one page size for writethrough
> writes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/file.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index edc86485065e..e44b6d26c1c6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1146,7 +1146,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		size_t tmp;
>  		struct folio *folio;
>  		pgoff_t index = pos >> PAGE_SHIFT;
> -		unsigned bytes = min(PAGE_SIZE - offset, num);
> +		unsigned int bytes;
> +		unsigned int folio_offset;
>  
>   again:
>  		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> @@ -1159,7 +1160,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
>  
> -		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
> +		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		bytes = min(folio_size(folio) - folio_offset, num);
> +
> +		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
>  		flush_dcache_folio(folio);
>  
>  		if (!tmp) {f 
> @@ -1180,6 +1184,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  
>  		err = 0;
>  		ap->folios[ap->num_folios] = folio;
> +		ap->descs[ap->num_folios].offset = folio_offset;
>  		ap->descs[ap->num_folios].length = tmp;
>  		ap->num_folios++;
>  
> @@ -1187,11 +1192,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  		pos += tmp;
>  		num -= tmp;
>  		offset += tmp;
> -		if (offset == PAGE_SIZE)
> +		if (offset == folio_size(folio))
>  			offset = 0;
>  
> -		/* If we copied full page, mark it uptodate */
> -		if (tmp == PAGE_SIZE)
> +		/* If we copied full folio, mark it uptodate */
> +		if (tmp == folio_size(folio))
>  			folio_mark_uptodate(folio);

Here am I confused. I think tmp can be a subpart of the folio, let's say
the folio is 2MB and somehow the again loop would iterate through the
folio in smaller steps. So the folio would be entirely written out, but
tmp might not be folio_size? Doesn't this need to sum up tmp for per
folio and then use that value?  And I actually wonder if we could use
the above "(offset == folio_size(folio)" as well. At least if the
initial offset for a folio is 0 it should work.


Thanks,
Bernd

>  
>  		if (folio_test_uptodate(folio)) {


