Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7C06D9FC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 20:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbjDFS0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbjDFS0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:26:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A4A258;
        Thu,  6 Apr 2023 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680805563; x=1712341563;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=71j8wA/jyuLPVIohqa23wmw7xUhIc2C3rcA0pSOT7kQ=;
  b=SwLzY0vIgdnUNoYOiwBiqZYCm7dTXGe9Iodg3/63HWpZmAiYk2brQJDv
   X2fYKsEyXsEUlvaU6hIniOeTXqbP5Y9rwdyqJeSNhUtnLU3Z7OJsyFw8D
   jz63OtW0dH8joET+smqIiunQCB3i97Z1UW9+iYXy5lQngL6+4iTY4jsat
   vdAr2yGTDJ1fO8NCaB131xbxzL2io/p3sgEzGOWtxfVXaDgDx7AQ5xiYp
   XdEFB2pwfEBSQgKZ4EnmG6j0Jy6kvuqPhwEjs1wgwUrKb5A86SRrkuQ/j
   gPHcnpFR7xBeVM19OvJTiv/RZy4JkUM8h2BGu3LZyUbLxocUrDgBpi6zJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="370642729"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="370642729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 11:26:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="811093631"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="811093631"
Received: from ticela-az-114.amr.corp.intel.com (HELO [10.251.3.106]) ([10.251.3.106])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 11:26:02 -0700
Message-ID: <83b2cb8017b945b2b3d3c9e65a3ba94a510ac20f.camel@linux.intel.com>
Subject: Re: [PATCH mm-unstable RFC 0/5] cgroup: eliminate atomic rstat
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 06 Apr 2023 11:26:02 -0700
In-Reply-To: <CAJD7tkZ5vh5ssDux1LStX9ZivmGmXsFyxfADGJD5AXDaMnGWRQ@mail.gmail.com>
References: <20230403220337.443510-1-yosryahmed@google.com>
         <CAJD7tkZ5vh5ssDux1LStX9ZivmGmXsFyxfADGJD5AXDaMnGWRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-04-03 at 15:04 -0700, Yosry Ahmed wrote:
> On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >=20
> > A previous patch series ([1] currently in mm-unstable) changed most
>=20
> .. and I naturally forgot to link this:
> [1] https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed@=
google.com/

Thanks. Saw this after I sent my request for link.

Tim
