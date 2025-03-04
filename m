Return-Path: <linux-fsdevel+bounces-43166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F026A4EDCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9EC16ECCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777E24C09A;
	Tue,  4 Mar 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="k4dNzeEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A661F5826;
	Tue,  4 Mar 2025 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117774; cv=none; b=jnFJr28O2SQ6JFTeCNwAs0o/MPNLLWUD8/9XUCtkCZCSSro0+3NHLX84AFPaclhD1d5xxaW9TAEuDn+zeo4VYiflI2rBALD23VaTniPa4bCEczjY+6BunxrDfHUE5IbY8CIo8rr2GcxTvfoGiM0qMTjQjjlupR4LehOr/2qjw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117774; c=relaxed/simple;
	bh=HCVoEwsf/cATAcfxzA4zs3ap5ZDWJYMRf90L0GuTS9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvasibZq28lgEcXKBrHwxXJRnKBgx3KKvlpp6pIdzDSzhJ/QqFYsYezo1vvzLlHgY9gN2cD30yRX1yLewzfWknWbVM9ZPgW8a6/AN9kClSWSWmQSRvzQQl1uvHd2Ll7d9cQ6XE5AuHgzHfPPKnXF4aycZwjrb1pSYTOj2uMtyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=k4dNzeEM; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z6mV03pmJzy62;
	Tue,  4 Mar 2025 20:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741117768;
	bh=zQTN4PvX1cRomYtYsS85mrVBY7pJdkMjtV7KTmHxcMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4dNzeEMp1jxV5i9SlaNP1Gx5oeFIZU9znK0L9QexhCvxyLekAbYFn6MS0MRV1BIl
	 TMZCIigxjXHl89Dk+XuiOj12L55TKG2NjcO4VvVsnm31BdeP6Cwk5fRTnzlPwfUezw
	 G1xVVOAcsEvz09m0N+q6YpyS/ayN2JlqQeb09ze8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z6mTz6Th4zB7g;
	Tue,  4 Mar 2025 20:49:27 +0100 (CET)
Date: Tue, 4 Mar 2025 20:49:27 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC PATCH 2/9] Refactor per-layer information in rulesets and
 rules
Message-ID: <20250304.aiGhah9lohh5@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <6e8887f204c9fbe7470e61876bc597932a8f74d9.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e8887f204c9fbe7470e61876bc597932a8f74d9.1741047969.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 04, 2025 at 01:12:58AM +0000, Tingmao Wang wrote:
> We need a place to store the supervisor pointer for each layer in
> a domain.  Currently, the domain has a trailing flexible array
> for handled access masks of each layer.  This patch extends it by
> creating a separate landlock_ruleset_layer structure that will
> hold this access mask, and make the ruleset's flexible array use
> this structure instead.
> 
> An alternative is to use landlock_hierarchy, but I have chosen to
> extend the FAM as this is makes it more clear the supervisor
> pointer is tied to layers, just like access masks.

We could indeed have a pointer in the  landlock_hierarchy and have a
dedicated bit in each layer's access_masks to indicate that this layer
is supervised.  This should simplify the whole patch series.

> 
> This patch doesn't make any functional changes nor add any
> supervise specific stuff.  It is purely to pave the way for
> future patches.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/ruleset.c  | 29 +++++++++---------
>  security/landlock/ruleset.h  | 59 ++++++++++++++++++++++--------------
>  security/landlock/syscalls.c |  2 +-
>  3 files changed, 52 insertions(+), 38 deletions(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 69742467a0cf..2cc6f7c5eb1b 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -31,9 +31,8 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  {
>  	struct landlock_ruleset *new_ruleset;
>  
> -	new_ruleset =
> -		kzalloc(struct_size(new_ruleset, access_masks, num_layers),
> -			GFP_KERNEL_ACCOUNT);
> +	new_ruleset = kzalloc(struct_size(new_ruleset, layer_stack, num_layers),
> +			      GFP_KERNEL_ACCOUNT);
>  	if (!new_ruleset)
>  		return ERR_PTR(-ENOMEM);
>  	refcount_set(&new_ruleset->usage, 1);
> @@ -104,8 +103,9 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
>  
>  static struct landlock_rule *
>  create_rule(const struct landlock_id id,
> -	    const struct landlock_layer (*const layers)[], const u32 num_layers,
> -	    const struct landlock_layer *const new_layer)
> +	    const struct landlock_rule_layer (*const layers)[],
> +	    const u32 num_layers,
> +	    const struct landlock_rule_layer *const new_layer)
>  {
>  	struct landlock_rule *new_rule;
>  	u32 new_num_layers;
> @@ -201,7 +201,7 @@ static void build_check_ruleset(void)
>   */
>  static int insert_rule(struct landlock_ruleset *const ruleset,
>  		       const struct landlock_id id,
> -		       const struct landlock_layer (*const layers)[],
> +		       const struct landlock_rule_layer (*const layers)[],
>  		       const size_t num_layers)
>  {
>  	struct rb_node **walker_node;
> @@ -284,7 +284,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
>  
>  static void build_check_layer(void)
>  {
> -	const struct landlock_layer layer = {
> +	const struct landlock_rule_layer layer = {

It's not useful to rename this struct.

>  		.level = ~0,
>  		.access = ~0,
>  	};
> @@ -299,7 +299,7 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>  			 const struct landlock_id id,
>  			 const access_mask_t access)
>  {
> -	struct landlock_layer layers[] = { {
> +	struct landlock_rule_layer layers[] = { {
>  		.access = access,
>  		/* When @level is zero, insert_rule() extends @ruleset. */
>  		.level = 0,
> @@ -344,7 +344,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
>  	/* Merges the @src tree. */
>  	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
>  					     node) {
> -		struct landlock_layer layers[] = { {
> +		struct landlock_rule_layer layers[] = { {
>  			.level = dst->num_layers,
>  		} };
>  		const struct landlock_id id = {
> @@ -389,8 +389,9 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
>  		err = -EINVAL;
>  		goto out_unlock;
>  	}
> -	dst->access_masks[dst->num_layers - 1] =
> -		landlock_upgrade_handled_access_masks(src->access_masks[0]);
> +	dst->layer_stack[dst->num_layers - 1].access_masks =
> +		landlock_upgrade_handled_access_masks(
> +			src->layer_stack[0].access_masks);
>  
>  	/* Merges the @src inode tree. */
>  	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
> @@ -472,8 +473,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
>  		goto out_unlock;
>  	}
>  	/* Copies the parent layer stack and leaves a space for the new layer. */
> -	memcpy(child->access_masks, parent->access_masks,
> -	       flex_array_size(parent, access_masks, parent->num_layers));
> +	memcpy(child->layer_stack, parent->layer_stack,
> +	       flex_array_size(parent, layer_stack, parent->num_layers));
>  
>  	if (WARN_ON_ONCE(!parent->hierarchy)) {
>  		err = -EINVAL;
> @@ -644,7 +645,7 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  	 * E.g. /a/b <execute> + /a <read> => /a/b <execute + read>
>  	 */
>  	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
> -		const struct landlock_layer *const layer =
> +		const struct landlock_rule_layer *const layer =
>  			&rule->layers[layer_level];
>  		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>  		const unsigned long access_req = access_request;
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 52f4f0af6ab0..a2605959f733 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -21,9 +21,10 @@
>  #include "object.h"
>  
>  /**
> - * struct landlock_layer - Access rights for a given layer
> + * struct landlock_rule_layer - Stores the access rights for a
> + * given layer in a rule.
>   */
> -struct landlock_layer {
> +struct landlock_rule_layer {
>  	/**
>  	 * @level: Position of this layer in the layer stack.
>  	 */
> @@ -102,10 +103,11 @@ struct landlock_rule {
>  	 */
>  	u32 num_layers;
>  	/**
> -	 * @layers: Stack of layers, from the latest to the newest, implemented
> -	 * as a flexible array member (FAM).
> +	 * @layers: Stack of layers, from the latest to the newest,
> +	 * implemented as a flexible array member (FAM). Only
> +	 * contains layers that has a rule for this object.
>  	 */
> -	struct landlock_layer layers[] __counted_by(num_layers);
> +	struct landlock_rule_layer layers[] __counted_by(num_layers);
>  };
>  
>  /**
> @@ -124,6 +126,18 @@ struct landlock_hierarchy {
>  	refcount_t usage;
>  };
>  
> +/**
> + * struct landlock_ruleset_layer - Store per-layer information
> + * within a domain (or a non-merged ruleset)
> + */
> +struct landlock_ruleset_layer {
> +	/**
> +	 * @access_masks: Contains the subset of filesystem and
> +	 * network actions that are restricted by a layer.
> +	 */
> +	struct access_masks access_masks;
> +};
> +
>  /**
>   * struct landlock_ruleset - Landlock ruleset
>   *
> @@ -187,18 +201,17 @@ struct landlock_ruleset {
>  			 */
>  			u32 num_layers;
>  			/**
> -			 * @access_masks: Contains the subset of filesystem and
> -			 * network actions that are restricted by a ruleset.
> -			 * A domain saves all layers of merged rulesets in a
> -			 * stack (FAM), starting from the first layer to the
> -			 * last one.  These layers are used when merging
> -			 * rulesets, for user space backward compatibility
> -			 * (i.e. future-proof), and to properly handle merged
> -			 * rulesets without overlapping access rights.  These
> -			 * layers are set once and never changed for the
> -			 * lifetime of the ruleset.
> +			 * @layer_stack: A domain saves all layers of merged
> +			 * rulesets in a stack (FAM), starting from the first
> +			 * layer to the last one.  These layers are used when
> +			 * merging rulesets, for user space backward
> +			 * compatibility (i.e. future-proof), and to properly
> +			 * handle merged rulesets without overlapping access
> +			 * rights.  These layers are set once and never
> +			 * changed for the lifetime of the ruleset.
>  			 */
> -			struct access_masks access_masks[];
> +			struct landlock_ruleset_layer
> +				layer_stack[] __counted_by(num_layers);
>  		};
>  	};
>  };
> @@ -248,7 +261,7 @@ landlock_union_access_masks(const struct landlock_ruleset *const domain)
>  
>  	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
>  		union access_masks_all layer = {
> -			.masks = domain->access_masks[layer_level],
> +			.masks = domain->layer_stack[layer_level].access_masks,
>  		};
>  
>  		matches.all |= layer.all;
> @@ -296,7 +309,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(fs_access_mask != fs_mask);
> -	ruleset->access_masks[layer_level].fs |= fs_mask;
> +	ruleset->layer_stack[layer_level].access_masks.fs |= fs_mask;
>  }
>  
>  static inline void
> @@ -308,7 +321,7 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(net_access_mask != net_mask);
> -	ruleset->access_masks[layer_level].net |= net_mask;
> +	ruleset->layer_stack[layer_level].access_masks.net |= net_mask;
>  }
>  
>  static inline void
> @@ -319,7 +332,7 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
>  
>  	/* Should already be checked in sys_landlock_create_ruleset(). */
>  	WARN_ON_ONCE(scope_mask != mask);
> -	ruleset->access_masks[layer_level].scope |= mask;
> +	ruleset->layer_stack[layer_level].access_masks.scope |= mask;
>  }
>  
>  static inline access_mask_t
> @@ -327,7 +340,7 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
>  			    const u16 layer_level)
>  {
>  	/* Handles all initially denied by default access rights. */
> -	return ruleset->access_masks[layer_level].fs |
> +	return ruleset->layer_stack[layer_level].access_masks.fs |
>  	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
>  }
>  
> @@ -335,14 +348,14 @@ static inline access_mask_t
>  landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
>  			     const u16 layer_level)
>  {
> -	return ruleset->access_masks[layer_level].net;
> +	return ruleset->layer_stack[layer_level].access_masks.net;
>  }
>  
>  static inline access_mask_t
>  landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>  			const u16 layer_level)
>  {
> -	return ruleset->access_masks[layer_level].scope;
> +	return ruleset->layer_stack[layer_level].access_masks.scope;
>  }
>  
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index a9760d252fc2..ead9b68168ad 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -313,7 +313,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>  		return -ENOMSG;
>  
>  	/* Checks that allowed_access matches the @ruleset constraints. */
> -	mask = ruleset->access_masks[0].fs;
> +	mask = landlock_get_fs_access_mask(ruleset, 0);
>  	if ((path_beneath_attr.allowed_access | mask) != mask)
>  		return -EINVAL;
>  
> -- 
> 2.39.5
> 
> 

