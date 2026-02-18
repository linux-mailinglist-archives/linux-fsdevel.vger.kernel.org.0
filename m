Return-Path: <linux-fsdevel+bounces-77652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOs+J1xMlmlUdgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:33:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AAF15AF03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CFCB3007ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA033B6E4;
	Wed, 18 Feb 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNphvBe6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF853376BA;
	Wed, 18 Feb 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771457622; cv=none; b=r1H4xOLq/E2hUD5pvmKTbQUyj1/fof8JY7cFus0e7gOcpw2qyGJOTxVuUMdxLI7Bw4BbDzWUMNE/zAaCkjga4nxtZ4BxtkOCHfYDIO2LGCJzmVXdMQTfLhDPBUUzR/qtbr6z8mWyL04Ui7tzzyioX0GSo5iZH9bXODxl1D0Duxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771457622; c=relaxed/simple;
	bh=D5BbzAcUzisA/eO9fnBpFALrBThvwHCcKR72kn6oMtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxiV2ddFLtLhZeNFV5WZmCke8YDkbQM1ruopHiWPQqfEfblB0lanXRap6ZDGLr87hu9B5mSiulOWYoBJ71PBnfAq70MGW1sdIeYAeIhNeprjthBMb9Aqww2IOn7f3HouIN3oiISn2wGXYaFOmVfjfwjY3i81lpgE577Ily0syfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNphvBe6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771457621; x=1802993621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D5BbzAcUzisA/eO9fnBpFALrBThvwHCcKR72kn6oMtU=;
  b=GNphvBe6TLvClFZiOF1iLAcZIPIkMpXCL1n/fLl9mwpFmjgvZ/bk+bym
   VtH6ybu1E6B3dxOGWeobX/oxnFVRXSceQDaJNWGGveCUy9KGcxTC6oXGR
   3pdR415hXLybug/J1eR0jwNZ/2VYSQ0Gq6xKDY1ihTFzOJWBbgOxk1NIp
   qGcmXyb0udU5Rc2vi84SziL/h3UZE8ioJocGe3hJ3bh/eyE3hjwI8W7mk
   II8jJ1jgBasfUU44QZcCJr2B0D63toQNbTtZe3E8rmq0iyrfNK1p0ug5E
   HfaW9/jOE6cAviKtZiLRudw9CkK+bRH0ZrpNuIWjpYbrKfxIwxY1t6S5F
   w==;
X-CSE-ConnectionGUID: 518DwjDaRySUeZ//r5kSMw==
X-CSE-MsgGUID: 1uT5jfVxTIC43NozSkGv2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="98004789"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="98004789"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:33:40 -0800
X-CSE-ConnectionGUID: HkCANN//T+2NNQk2+gCxtw==
X-CSE-MsgGUID: cEuOHjX9Qom/uXF1mOq38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214352687"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.212]) ([10.125.109.212])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:33:37 -0800
Message-ID: <89c2f617-23c7-4767-8712-cfe32260bfdf@intel.com>
Date: Wed, 18 Feb 2026 16:33:36 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 04/19] dax: Save the kva from memremap
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
 <20260118223138.92368-1-john@jagalactic.com>
 <0100019bd33c54b5-81c8e4b0-2692-47bb-b555-2657a7f297ba-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33c54b5-81c8e4b0-2692-47bb-b555-2657a7f297ba-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77652-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B9AAF15AF03
X-Rspamd-Action: no action



On 1/18/26 3:31 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> Save the kva from memremap because we need it for iomap rw support.
> 
> Prior to famfs, there were no iomap users of /dev/dax - so the virtual
> address from memremap was not needed.
> 
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dax/dax-private.h | 2 ++
>  drivers/dax/fsdev.c       | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 0867115aeef2..4ae4d829d3ee 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -69,6 +69,7 @@ struct dev_dax_range {
>   * data while the device is activated in the driver.
>   * @region - parent region
>   * @dax_dev - core dax functionality
> + * @virt_addr: kva from memremap; used by fsdev_dax
>   * @target_node: effective numa node if dev_dax memory range is onlined
>   * @dyn_id: is this a dynamic or statically created instance
>   * @id: ida allocated id when the dax_region is not static
> @@ -81,6 +82,7 @@ struct dev_dax_range {
>  struct dev_dax {
>  	struct dax_region *region;
>  	struct dax_device *dax_dev;
> +	void *virt_addr;
>  	unsigned int align;
>  	int target_node;
>  	bool dyn_id;
> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 29b7345f65b1..72f78f606e06 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -201,6 +201,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx\n",
>  		       __func__, phys, pgmap_phys, data_offset);
>  	}
> +	dev_dax->virt_addr = addr + data_offset;
>  
>  	inode = dax_inode(dax_dev);
>  	cdev = inode->i_cdev;


