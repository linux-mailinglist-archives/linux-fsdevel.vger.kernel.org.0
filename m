Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77671798AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 20:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgCDTKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 14:10:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50986 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbgCDTKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:10:44 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 024JAQLf008324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Mar 2020 14:10:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 399CF42045B; Wed,  4 Mar 2020 14:10:26 -0500 (EST)
Date:   Wed, 4 Mar 2020 14:10:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200304191026.GC74069@mit.edu>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
 <20200304185056.GM189690@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304185056.GM189690@mtj.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 01:50:56PM -0500, Tejun Heo wrote:
> 
> Lifetime rules in block layer are kinda nebulous. Some of it comes
> from the fact that some objects are reused. Instead of the usual,
> create-use-release, they get repurposed to be associated with
> something else. When looking at such an object from some paths, we
> don't necessarily have ownership of all of the members.

I wonder if the current rules should be better documented, and that
perhaps we should revisit some of them so we can tighten them down?
For things that are likely to be long-lived, such as anything
corresponding to a bdi or block device, perhaps it would be better if
the lifetime rules can be made tighter?  The cost of needing to
release and reallocate longer lived objects is going to be negligible,
and benefits of improving code readability, reliability, and
robuestness might be well worth it.

     		  	       	   	       - Ted
