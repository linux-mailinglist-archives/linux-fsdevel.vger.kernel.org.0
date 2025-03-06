Return-Path: <linux-fsdevel+bounces-43312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC9DA540E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 03:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A52B3A9105
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50678192B96;
	Thu,  6 Mar 2025 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="KX/4V2+4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxWXD82z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6418FC80;
	Thu,  6 Mar 2025 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229887; cv=none; b=PU9jz+AQHvpd0LtUodXsPkKEJ4vxtW1wLryiRGBRBrOv9HNvw4wQgyBIPlEbrQTbL9TwQF2yAV3s3UUw24uRtABMtRljuuclt4PkCb4iuZmJimPAVHbqvlGjvFsib+ZmBksIbKRBqWhtYYhCGVBzEn1hLLNFX5uu87pm+H5wsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229887; c=relaxed/simple;
	bh=Ad4ML6dLlb3hxPvPAhDArnmOKeuNE0mh3TH53zvRTgk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ams5qACeBad8Lb7vsaV0jrPUi5I93bRhb1Q/TZpiO6EM6emWjvo9rZoKI88EPe70vGpjxTAK23xVOQDN9AMc7u/0whuK7LTjOIrnKoWG8GzZqbMO8M8b28RNCx0tsjKH/kiYXLocUQCO8KkfQu4JfGIsUSxT8DsbcguTX5weCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=KX/4V2+4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxWXD82z; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailflow.phl.internal (Postfix) with ESMTP id 0894E201CC0;
	Wed,  5 Mar 2025 21:58:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 05 Mar 2025 21:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741229884;
	 x=1741233484; bh=MXpIqvpOhHZkjJDwFs7CqEuHVland8yTI2eh6L5/zpA=; b=
	KX/4V2+4AGO/q0XkLDScjvTsOc0YMIJIcUkkxdm1j4D6jr3PHntyrGMKZ5detYY1
	e0qFEsXMDugmJAxddjTMJ7dpoQcg8qk0rAJtwZquLAlHt/74CYp5N8/eTkyUCsRL
	YcIxSg5C7wDvDY70/FcPqE0KUAZ7CwuG0AjpbyKhb/U2iSO0EF1uhdnPw5pDS9J9
	OWcCg4aLs5R85c4KB9Ngv3h+skQVLyo0gv288we5hGQLwWF/HtGKPfFpO2DmeAp7
	4iDbT3y1lV2JrPWESryFzOe3b0RSgbwKGBVg0HIOKPZtxYXYqzpHbceUAtp0xql3
	3v0j2DIa6U0DMLn2eCGQjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741229884; x=
	1741233484; bh=MXpIqvpOhHZkjJDwFs7CqEuHVland8yTI2eh6L5/zpA=; b=b
	xWXD82zE9lZlRJVyKrI+/wDXMMdp83U3pJ9D+8+833rmz2466w5UtUzBsJy+ge48
	u9Z3sa0zXmpkstJAlgX2pngC/J1WHqjEo1cL1tPvf3SIaLvCmczeu8XYsujQW+zJ
	IU3XbJH0QACHG1bYwRuEv6fk2wjlg4q5K0tMheY0cnVsVfqNzc5KlIbq0VwBbCNq
	SiDAXM8HBdBMP4FLhRHXxfByGUCTm8Y68EWo8RhpPnrRC6ryPsWm2qyZI5qifpt0
	ZCAi2ATR9TOCfDFq6ZlVuxZi7MYWEepWtxY8WZiA99Su+zUB26koIdqkx1Pc2eBu
	mpue2LLIIVcjv+kujnj5g==
X-ME-Sender: <xms:Ow_JZ00TDqlEE4b71fOg2VZ9rxXE8bbzq9hXJwd-MhKUa4xOtw4tWQ>
    <xme:Ow_JZ_GBR3kUvkPW6ohcFq_s4bkQxSE5XKhU3rw0ZGaH1PPszCwtndb8hBD9DcFg8
    22q9HQI2jUS07ykHCs>
X-ME-Received: <xmr:Ow_JZ84xvaFta8dtc5v2iLs-kPhAsAK0H0R-0Uw2NRJoyCOzVYiE1NaqzSMRGlJs3Bgr6d3_EPAOOkWn0oecfkDHB3Mhas3P9fDWwZrxiw6VTl4UYq489j8eh1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepvdejveelkeektddthfeludekudehieevffetkeffvdef
    gfevveegkeevveejveeinecuffhomhgrihhnpehlrgihvghrpghlvghvvghlrdhnvghtpd
    grtggtvghsshgpmhgrshhkshdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtoh
    epkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdr
    nhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqshgvtghurhhithih
    qdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirh
    ejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehrvghpnhhophesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:Ow_JZ920GKsElrLl-Hlofz9KWCRWiTpkuKHFcvDPv-Qam4QQDPi5Cw>
    <xmx:Ow_JZ3FUA6puLGGC7nYUOArhGgLtlqHeIQwM2BnQ6QyxsUskn5tylw>
    <xmx:Ow_JZ28WW7g81nFlPsKGMs1IrjOiArTYaj2CAj_qJpmOnhBZAYy_qg>
    <xmx:Ow_JZ8nY4bdZ9f8t3LTO4l7qFEA7HBHEqiBcREYqo-vBzYnEyNw9kQ>
    <xmx:Ow_JZ4OfnbSgwo58Xx4igjj5Rt-iKvRnE_Oj_eVIWIzqPRCnphYC5fBi>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 21:58:02 -0500 (EST)
Message-ID: <4e0ed692-50e7-4665-962b-3cc1694e441a@maowtm.org>
Date: Thu, 6 Mar 2025 02:58:01 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH 2/9] Refactor per-layer information in rulesets and
 rules
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
References: <cover.1741047969.git.m@maowtm.org>
 <6e8887f204c9fbe7470e61876bc597932a8f74d9.1741047969.git.m@maowtm.org>
 <20250304.aiGhah9lohh5@digikod.net>
Content-Language: en-US, en-GB
In-Reply-To: <20250304.aiGhah9lohh5@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 19:49, Mickaël Salaün wrote:

> We could indeed have a pointer in the  landlock_hierarchy and have a
> dedicated bit in each layer's access_masks to indicate that this layer
> is supervised.  This should simplify the whole patch series.

That seems sensible.  I did consider using the landlock_hierarchy, but 
chose the current way as it initially seemed more sensible, but on 
second thought this means that we have to carefully increment all the 
refcounts on domain merge etc.  On the other hand storing the supervisor 
pointer in the hierarchy, if we have an extra bit in struct access_masks 
then we can quickly determine if supervisors are involved without 
effectively walking a linked list, which is nice.

Actually, just to check, is the reason why we have the access_masks FAM 
in the ruleset purely for performance? Initially I wasn't sure if each 
layer correspond 1-to-1 with landlock_hierarchy, since otherwise it 
seemed to me you could just put the access mask in the hierarchy too.
In other words, is it right to assume that, if a domain has 3 layers, 
for example, then domain->hierarchy correspond to the third layer, 
domain->hierarchy->parent correspond to the second, and
d->h->parent->parent would be the first layer's hierarchy?

> 
>>
>> This patch doesn't make any functional changes nor add any
>> supervise specific stuff.  It is purely to pave the way for
>> future patches.
>>
>> Signed-off-by: Tingmao Wang <m@maowtm.org>
>> ---
>>   security/landlock/ruleset.c  | 29 +++++++++---------
>>   security/landlock/ruleset.h  | 59 ++++++++++++++++++++++--------------
>>   security/landlock/syscalls.c |  2 +-
>>   3 files changed, 52 insertions(+), 38 deletions(-)
>>
>> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
>> index 69742467a0cf..2cc6f7c5eb1b 100644
>> --- a/security/landlock/ruleset.c
>> +++ b/security/landlock/ruleset.c
>> @@ -31,9 +31,8 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>>   {
>>   	struct landlock_ruleset *new_ruleset;
>>   
>> -	new_ruleset =
>> -		kzalloc(struct_size(new_ruleset, access_masks, num_layers),
>> -			GFP_KERNEL_ACCOUNT);
>> +	new_ruleset = kzalloc(struct_size(new_ruleset, layer_stack, num_layers),
>> +			      GFP_KERNEL_ACCOUNT);
>>   	if (!new_ruleset)
>>   		return ERR_PTR(-ENOMEM);
>>   	refcount_set(&new_ruleset->usage, 1);
>> @@ -104,8 +103,9 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
>>   
>>   static struct landlock_rule *
>>   create_rule(const struct landlock_id id,
>> -	    const struct landlock_layer (*const layers)[], const u32 num_layers,
>> -	    const struct landlock_layer *const new_layer)
>> +	    const struct landlock_rule_layer (*const layers)[],
>> +	    const u32 num_layers,
>> +	    const struct landlock_rule_layer *const new_layer)
>>   {
>>   	struct landlock_rule *new_rule;
>>   	u32 new_num_layers;
>> @@ -201,7 +201,7 @@ static void build_check_ruleset(void)
>>    */
>>   static int insert_rule(struct landlock_ruleset *const ruleset,
>>   		       const struct landlock_id id,
>> -		       const struct landlock_layer (*const layers)[],
>> +		       const struct landlock_rule_layer (*const layers)[],
>>   		       const size_t num_layers)
>>   {
>>   	struct rb_node **walker_node;
>> @@ -284,7 +284,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
>>   
>>   static void build_check_layer(void)
>>   {
>> -	const struct landlock_layer layer = {
>> +	const struct landlock_rule_layer layer = {
> 
> It's not useful to rename this struct.
> 
>>   		.level = ~0,
>>   		.access = ~0,
>>   	};
>> @@ -299,7 +299,7 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>>   			 const struct landlock_id id,
>>   			 const access_mask_t access)
>>   {
>> -	struct landlock_layer layers[] = { {
>> +	struct landlock_rule_layer layers[] = { {
>>   		.access = access,
>>   		/* When @level is zero, insert_rule() extends @ruleset. */
>>   		.level = 0,
>> @@ -344,7 +344,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
>>   	/* Merges the @src tree. */
>>   	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
>>   					     node) {
>> -		struct landlock_layer layers[] = { {
>> +		struct landlock_rule_layer layers[] = { {
>>   			.level = dst->num_layers,
>>   		} };
>>   		const struct landlock_id id = {
>> @@ -389,8 +389,9 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
>>   		err = -EINVAL;
>>   		goto out_unlock;
>>   	}
>> -	dst->access_masks[dst->num_layers - 1] =
>> -		landlock_upgrade_handled_access_masks(src->access_masks[0]);
>> +	dst->layer_stack[dst->num_layers - 1].access_masks =
>> +		landlock_upgrade_handled_access_masks(
>> +			src->layer_stack[0].access_masks);
>>   
>>   	/* Merges the @src inode tree. */
>>   	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
>> @@ -472,8 +473,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
>>   		goto out_unlock;
>>   	}
>>   	/* Copies the parent layer stack and leaves a space for the new layer. */
>> -	memcpy(child->access_masks, parent->access_masks,
>> -	       flex_array_size(parent, access_masks, parent->num_layers));
>> +	memcpy(child->layer_stack, parent->layer_stack,
>> +	       flex_array_size(parent, layer_stack, parent->num_layers));
>>   
>>   	if (WARN_ON_ONCE(!parent->hierarchy)) {
>>   		err = -EINVAL;
>> @@ -644,7 +645,7 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>>   	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
>>   	 */
>>   	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
>> -		const struct landlock_layer *const layer =
>> +		const struct landlock_rule_layer *const layer =
>>   			&rule->layers[layer_level];
>>   		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>>   		const unsigned long access_req = access_request;
>> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
>> index 52f4f0af6ab0..a2605959f733 100644
>> --- a/security/landlock/ruleset.h
>> +++ b/security/landlock/ruleset.h
>> @@ -21,9 +21,10 @@
>>   #include "object.h"
>>   
>>   /**
>> - * struct landlock_layer - Access rights for a given layer
>> + * struct landlock_rule_layer - Stores the access rights for a
>> + * given layer in a rule.
>>    */
>> -struct landlock_layer {
>> +struct landlock_rule_layer {
>>   	/**
>>   	 * @level: Position of this layer in the layer stack.
>>   	 */
>> @@ -102,10 +103,11 @@ struct landlock_rule {
>>   	 */
>>   	u32 num_layers;
>>   	/**
>> -	 * @layers: Stack of layers, from the latest to the newest, implemented
>> -	 * as a flexible array member (FAM).
>> +	 * @layers: Stack of layers, from the latest to the newest,
>> +	 * implemented as a flexible array member (FAM). Only
>> +	 * contains layers that has a rule for this object.
>>   	 */
>> -	struct landlock_layer layers[] __counted_by(num_layers);
>> +	struct landlock_rule_layer layers[] __counted_by(num_layers);
>>   };
>>   
>>   /**
>> @@ -124,6 +126,18 @@ struct landlock_hierarchy {
>>   	refcount_t usage;
>>   };
>>   
>> +/**
>> + * struct landlock_ruleset_layer - Store per-layer information
>> + * within a domain (or a non-merged ruleset)
>> + */
>> +struct landlock_ruleset_layer {
>> +	/**
>> +	 * @access_masks: Contains the subset of filesystem and
>> +	 * network actions that are restricted by a layer.
>> +	 */
>> +	struct access_masks access_masks;
>> +};
>> +
>>   /**
>>    * struct landlock_ruleset - Landlock ruleset
>>    *
>> @@ -187,18 +201,17 @@ struct landlock_ruleset {
>>   			 */
>>   			u32 num_layers;
>>   			/**
>> -			 * @access_masks: Contains the subset of filesystem and
>> -			 * network actions that are restricted by a ruleset.
>> -			 * A domain saves all layers of merged rulesets in a
>> -			 * stack (FAM), starting from the first layer to the
>> -			 * last one.  These layers are used when merging
>> -			 * rulesets, for user space backward compatibility
>> -			 * (i.e. future-proof), and to properly handle merged
>> -			 * rulesets without overlapping access rights.  These
>> -			 * layers are set once and never changed for the
>> -			 * lifetime of the ruleset.
>> +			 * @layer_stack: A domain saves all layers of merged
>> +			 * rulesets in a stack (FAM), starting from the first
>> +			 * layer to the last one.  These layers are used when
>> +			 * merging rulesets, for user space backward
>> +			 * compatibility (i.e. future-proof), and to properly
>> +			 * handle merged rulesets without overlapping access
>> +			 * rights.  These layers are set once and never
>> +			 * changed for the lifetime of the ruleset.
>>   			 */
>> -			struct access_masks access_masks[];
>> +			struct landlock_ruleset_layer
>> +				layer_stack[] __counted_by(num_layers);
>>   		};
>>   	};
>>   };
>> @@ -248,7 +261,7 @@ landlock_union_access_masks(const struct landlock_ruleset *const domain)
>>   
>>   	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
>>   		union access_masks_all layer = {
>> -			.masks = domain->access_masks[layer_level],
>> +			.masks = domain->layer_stack[layer_level].access_masks,
>>   		};
>>   
>>   		matches.all |= layer.all;
>> @@ -296,7 +309,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>>   
>>   	/* Should already be checked in sys_landlock_create_ruleset(). */
>>   	WARN_ON_ONCE(fs_access_mask != fs_mask);
>> -	ruleset->access_masks[layer_level].fs |= fs_mask;
>> +	ruleset->layer_stack[layer_level].access_masks.fs |= fs_mask;
>>   }
>>   
>>   static inline void
>> @@ -308,7 +321,7 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
>>   
>>   	/* Should already be checked in sys_landlock_create_ruleset(). */
>>   	WARN_ON_ONCE(net_access_mask != net_mask);
>> -	ruleset->access_masks[layer_level].net |= net_mask;
>> +	ruleset->layer_stack[layer_level].access_masks.net |= net_mask;
>>   }
>>   
>>   static inline void
>> @@ -319,7 +332,7 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
>>   
>>   	/* Should already be checked in sys_landlock_create_ruleset(). */
>>   	WARN_ON_ONCE(scope_mask != mask);
>> -	ruleset->access_masks[layer_level].scope |= mask;
>> +	ruleset->layer_stack[layer_level].access_masks.scope |= mask;
>>   }
>>   
>>   static inline access_mask_t
>> @@ -327,7 +340,7 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
>>   			    const u16 layer_level)
>>   {
>>   	/* Handles all initially denied by default access rights. */
>> -	return ruleset->access_masks[layer_level].fs |
>> +	return ruleset->layer_stack[layer_level].access_masks.fs |
>>   	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>>   }
>>   
>> @@ -335,14 +348,14 @@ static inline access_mask_t
>>   landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
>>   			     const u16 layer_level)
>>   {
>> -	return ruleset->access_masks[layer_level].net;
>> +	return ruleset->layer_stack[layer_level].access_masks.net;
>>   }
>>   
>>   static inline access_mask_t
>>   landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>>   			const u16 layer_level)
>>   {
>> -	return ruleset->access_masks[layer_level].scope;
>> +	return ruleset->layer_stack[layer_level].access_masks.scope;
>>   }
>>   
>>   bool landlock_unmask_layers(const struct landlock_rule *const rule,
>> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
>> index a9760d252fc2..ead9b68168ad 100644
>> --- a/security/landlock/syscalls.c
>> +++ b/security/landlock/syscalls.c
>> @@ -313,7 +313,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>>   		return -ENOMSG;
>>   
>>   	/* Checks that allowed_access matches the @ruleset constraints. */
>> -	mask = ruleset->access_masks[0].fs;
>> +	mask = landlock_get_fs_access_mask(ruleset, 0);
>>   	if ((path_beneath_attr.allowed_access | mask) != mask)
>>   		return -EINVAL;
>>   
>> -- 
>> 2.39.5
>>
>>


