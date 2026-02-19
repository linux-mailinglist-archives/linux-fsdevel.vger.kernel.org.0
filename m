Return-Path: <linux-fsdevel+bounces-77737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GHtIBpxl2nUygIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:22:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23D16249C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D98F1300E5B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 20:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB1C318BB3;
	Thu, 19 Feb 2026 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDzks09n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3E2F28FC;
	Thu, 19 Feb 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532564; cv=none; b=fOr9A+82WP4/G7xbUWXx9l0p/8Efx2IcIJ/nA1KAZubZ+z3Eers7i76TRy5kHxmvfQO5FeuGRhdx9YxJrzeRchdofveZpMuqyG40k8xVwIsaS2dmF0O3uvWwSqOawNNVadlKSFHqUi3X7nrBEO/7CDEsRGz0SVc1R7PIYOeFYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532564; c=relaxed/simple;
	bh=mISTdwX34M5liOVlJkRN3K1BQaKXoJekf1yDkjF03CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTGrme0NGPAqPkax6lXHxhyOlJoh+7TXYYd8YBUKK4KY3goicveQfSAbKLiWAZKzxZ6vrh7PcUxQ08dl1ME48pKJONWTZTZ1euLfufRjxCc6T9PpDXumWFtjxhRXGnrDBRM2A/kZsQ0V9fcmhYVYdCzgMkpcjAw1tdVZQWk3xCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDzks09n; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771532562; x=1803068562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mISTdwX34M5liOVlJkRN3K1BQaKXoJekf1yDkjF03CU=;
  b=RDzks09n7xy5dHoqEAm2rrO7YvS+yg8klr2Qga1G1k6N2WDR5bsTFsyS
   s9uDjWOvVcde8hl7Qv6dSi9f7XGH7LBXrTh6Fd9pboclpYK8m+98L8Zso
   h+fnfyNn/TeLcFx3NENLfWbB74SYRdnRyiUlYOrjWw0zfCNb7AzybIRvf
   5zYouZDltcUguN+CSV7LufaewF+uUiKyMopbkwda4nXpetzfcP93RYrLh
   jJGT7/2YegqjfGKxaH/ZKN7TCHrbhGi4NOLMcul7Vzfr13y6VAK2nqck4
   Jgw+Yx1MV9MW5U1cjovIm9KL2fJSV0haVwU+8pTiZtKX77yDIwX0HhGzE
   Q==;
X-CSE-ConnectionGUID: a8YdTIusQ7a+DwVVGVPN8g==
X-CSE-MsgGUID: DW+1JihgTvarvaNxd699Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76245808"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76245808"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:22:41 -0800
X-CSE-ConnectionGUID: k5Z28KJaRVGutfNK18nHww==
X-CSE-MsgGUID: ZDWx20A/SIamqCpS7y+4xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="212836081"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:22:38 -0800
Message-ID: <124bdd0a-c7d8-40e3-9d1d-481d73fd9186@intel.com>
Date: Thu, 19 Feb 2026 13:22:36 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 18/19] famfs_fuse: Add famfs fmap metadata
 documentation
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223409.92668-1-john@jagalactic.com>
 <0100019bd33eab0d-e982dfea-fdc0-4f02-b60f-9d4897fdcb7d-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33eab0d-e982dfea-fdc0-4f02-b60f-9d4897fdcb7d-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77737-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[groves.net:email,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 2A23D16249C
X-Rspamd-Action: no action



On 1/18/26 3:34 PM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> This describes the fmap metadata - both simple and interleaved
> 
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  fs/fuse/famfs_kfmap.h | 73 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> index 0fff841f5a9e..970ad802b492 100644
> --- a/fs/fuse/famfs_kfmap.h
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -7,6 +7,79 @@
>  #ifndef FAMFS_KFMAP_H
>  #define FAMFS_KFMAP_H
>  
> +/* KABI version 43 (aka v2) fmap structures
> + *
> + * The location of the memory backing for a famfs file is described by
> + * the response to the GET_FMAP fuse message (defined in
> + * include/uapi/linux/fuse.h
> + *
> + * There are currently two extent formats: Simple and Interleaved.
> + *
> + * Simple extents are just (devindex, offset, length) tuples, where devindex
> + * references a devdax device that must be retrievable via the GET_DAXDEV
> + * message/response.
> + *
> + * The extent list size must be >= file_size.
> + *
> + * Interleaved extents merit some additional explanation. Interleaved
> + * extents stripe data across a collection of strips. Each strip is a
> + * contiguous allocation from a single devdax device - and is described by
> + * a simple_extent structure.
> + *
> + * Interleaved_extent example:
> + *   ie_nstrips = 4
> + *   ie_chunk_size = 2MiB
> + *   ie_nbytes = 24MiB
> + *
> + * ┌────────────┐────────────┐────────────┐────────────┐
> + * │Chunk = 0   │Chunk = 1   │Chunk = 2   │Chunk = 3   │
> + * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
> + * │Stripe = 0  │Stripe = 0  │Stripe = 0  │Stripe = 0  │
> + * │            │            │            │            │
> + * └────────────┘────────────┘────────────┘────────────┘
> + * │Chunk = 4   │Chunk = 5   │Chunk = 6   │Chunk = 7   │
> + * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
> + * │Stripe = 1  │Stripe = 1  │Stripe = 1  │Stripe = 1  │
> + * │            │            │            │            │
> + * └────────────┘────────────┘────────────┘────────────┘
> + * │Chunk = 8   │Chunk = 9   │Chunk = 10  │Chunk = 11  │
> + * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
> + * │Stripe = 2  │Stripe = 2  │Stripe = 2  │Stripe = 2  │
> + * │            │            │            │            │
> + * └────────────┘────────────┘────────────┘────────────┘
> + *
> + * * Data is laid out across chunks in chunk # order
> + * * Columns are strips
> + * * Strips are contiguous devdax extents, normally each coming from a
> + *   different memory device
> + * * Rows are stripes
> + * * The number of chunks is (int)((file_size + chunk_size - 1) / chunk_size)
> + *   (and obviously the last chunk could be partial)
> + * * The stripe_size = (nstrips * chunk_size)
> + * * chunk_num(offset) = offset / chunk_size    //integer division
> + * * strip_num(offset) = chunk_num(offset) % nchunks
> + * * stripe_num(offset) = offset / stripe_size  //integer division
> + * * ...You get the idea - see the code for more details...
> + *
> + * Some concrete examples from the layout above:
> + * * Offset 0 in the file is offset 0 in chunk 0, which is offset 0 in
> + *   strip 0
> + * * Offset 4MiB in the file is offset 0 in chunk 2, which is offset 0 in
> + *   strip 2
> + * * Offset 15MiB in the file is offset 1MiB in chunk 7, which is offset
> + *   3MiB in strip 3
> + *
> + * Notes about this metadata format:
> + *
> + * * For various reasons, chunk_size must be a multiple of the applicable
> + *   PAGE_SIZE
> + * * Since chunk_size and nstrips are constant within an interleaved_extent,
> + *   resolving a file offset to a strip offset within a single
> + *   interleaved_ext is order 1.
> + * * If nstrips==1, a list of interleaved_ext structures degenerates to a
> + *   regular extent list (albeit with some wasted struct space).
> + */
> +
>  /*
>   * The structures below are the in-memory metadata format for famfs files.
>   * Metadata retrieved via the GET_FMAP response is converted to this format


