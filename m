Return-Path: <linux-fsdevel+bounces-9480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F11841A50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 04:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7F11C2222B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E937701;
	Tue, 30 Jan 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iycBlVWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD6374C9;
	Tue, 30 Jan 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584660; cv=none; b=d7iO/0Uw33oFJObVRS8YK4HFTnb5FJpaByfOeBnuTGfoRkfAmTuXc5fnPyjRTQPpSUYzL5wS3KsYQUOZHupZaR/FrIkJkta2eYX0uQf1JALKeL0U1eNtpxSjPHvTeDqS6JkBHIgx8UsShvC1T93IEbhy8nJSsDCkOINMYXbQEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584660; c=relaxed/simple;
	bh=wcpqROo/Nav+p/3mZ66wGUmf7vdiOv5PYmXgj8P2Y88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwtBITNvQuyDZL7aFpl2JkjJ99uQvOqzuZfuULMu+wk0ew1aYkhaITEa/P0cNeO3ACjWf2paL/PdOlouBJB8aY3sGdXx2yIVcLyp8sxdRasaxXc45rensoKb5yHf+SreSBvKTgXgKVx84vTHmichBOXEsnyMta3kKzp9Tag9QsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iycBlVWE; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706584658; x=1738120658;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wcpqROo/Nav+p/3mZ66wGUmf7vdiOv5PYmXgj8P2Y88=;
  b=iycBlVWEqvkF9uAcwSqxI+lk50VQS2frOlFTyMeuXMT9a2g4it/ayJhd
   3u/lrR8zuB4gutWN4zPVm+S6Ko7/gPmKQTRY0WoYwrc9XWD90k5kZa1cP
   BeFoKjKehiZ1Ho0RMpYsml+fTc1Aiccqty17GGAp+uBpSevLUrsBokplu
   Mm6mv+kpFXVRpVV8rD1RgTvpPFfjC/iH06QZiPeMWVRIiz2WT4m+Mi/Bs
   SUHGGklAf/pIXNQuoAS7XJzxMZ5P3+GEdmk4sn7TdC70h0eREAgUN0i/J
   KLeL3boZOLEgXBF9vESqEOWZPbNm6DQrU7ZWu797pym8D6K3p7KeqS0BE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="406873069"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="406873069"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:17:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3674612"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:17:32 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-doc@vger.kernel.org>,
  <linux-fsdevel@vger.kernel.org>,  <linux-api@vger.kernel.org>,
  <corbet@lwn.net>,  <akpm@linux-foundation.org>,  <honggyu.kim@sk.com>,
  <rakie.kim@sk.com>,  <hyeongtak.ji@sk.com>,  <mhocko@kernel.org>,
  <vtavarespetr@micron.com>,  <jgroves@micron.com>,
  <ravis.opensrc@micron.com>,  <sthanneeru@micron.com>,
  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  <hannes@cmpxchg.org>,
  <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 4/4] mm/mempolicy: change cur_il_weight to atomic and
 carry the node with it
In-Reply-To: <ZbfqVHA9+38/j3Mq@memverge.com> (Gregory Price's message of "Mon,
	29 Jan 2024 13:11:32 -0500")
References: <20240125184345.47074-1-gregory.price@memverge.com>
	<20240125184345.47074-5-gregory.price@memverge.com>
	<87sf2klez8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbPf6d2cQykdl3Eb@memverge.com>
	<877cjsk0yd.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZbfI3+nhgQlNKMPG@memverge.com> <ZbfqVHA9+38/j3Mq@memverge.com>
Date: Tue, 30 Jan 2024 11:15:35 +0800
Message-ID: <875xzbika0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Jan 29, 2024 at 10:48:47AM -0500, Gregory Price wrote:
>> On Mon, Jan 29, 2024 at 04:17:46PM +0800, Huang, Ying wrote:
>> > Gregory Price <gregory.price@memverge.com> writes:
>> > 
>> > But, in contrast, it's bad to put task-local "current weight" in
>> > mempolicy.  So, I think that it's better to move cur_il_weight to
>> > task_struct.  And maybe combine it with current->il_prev.
>> > 
>> Style question: is it preferable add an anonymous union into task_struct:
>> 
>> union {
>>     short il_prev;
>>     atomic_t wil_node_weight;
>> };
>> 
>> Or should I break out that union explicitly in mempolicy.h?
>> 
>
> Having attempted this, it looks like including mempolicy.h into sched.h
> is a non-starter.  There are build issues likely associated from the
> nested include of uapi/linux/mempolicy.h
>
> So I went ahead and did the following.  Style-wise If it's better to just
> integrate this as an anonymous union in task_struct, let me know, but it
> seemed better to add some documentation here.
>
> I also added static get/set functions to mempolicy.c to touch these
> values accordingly.
>
> As suggested, I changed things to allow 0-weight in il_prev.node_weight
> adjusted the logic accordingly. Will be testing this for a day or so
> before sending out new patches.
>

Thanks about this again.  It seems that we don't need to touch
task->il_prev and task->il_weight during rebinding for weighted
interleave too.

For weighted interleaving, il_prev is the node used for previous
allocation, il_weight is the weight after previous allocation.  So
weighted_interleave_nodes() could be as follows,

unsigned int weighted_interleave_nodes(struct mempolicy *policy)
{
        unsigned int nid;
        struct task_struct *me = current;

        nid = me->il_prev;
        if (!me->il_weight || !node_isset(nid, policy->nodes)) {
                nid = next_node_in(...);
                me->il_prev = nid;
                me->il_weight = weights[nid];
        }
        me->il_weight--;

        return nid;
}

If this works, we can just add il_weight into task_struct.

--
Best Regards,
Huang, Ying

