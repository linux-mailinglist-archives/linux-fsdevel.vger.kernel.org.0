Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7893510A50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEAPz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:55:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEAPz4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:55:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ECD1A78;
        Wed,  1 May 2019 08:55:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2FD3F719;
        Wed,  1 May 2019 08:55:54 -0700 (PDT)
Date:   Wed, 1 May 2019 16:55:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] io_uring: avoid page allocation warnings
Message-ID: <20190501155551.GF11740@lakrids.cambridge.arm.com>
References: <20190430132405.8268-1-mark.rutland@arm.com>
 <20190430141810.GF13796@bombadil.infradead.org>
 <20190430145938.GA8314@lakrids.cambridge.arm.com>
 <a1af3017-6572-e828-dc8a-a5c8458e6b5a@kernel.dk>
 <20190430170302.GD8314@lakrids.cambridge.arm.com>
 <0bd395a0-e0d3-16a5-e29f-557e97782a48@kernel.dk>
 <20190501103026.GA11740@lakrids.cambridge.arm.com>
 <710a3048-ccab-260d-d8b7-1d51ff6d589d@kernel.dk>
 <20190501150921.GE11740@lakrids.cambridge.arm.com>
 <88fee953-ea3e-b9c0-650c-60faea07dd04@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fee953-ea3e-b9c0-650c-60faea07dd04@kernel.dk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 09:29:25AM -0600, Jens Axboe wrote:
> On 5/1/19 9:09 AM, Mark Rutland wrote:
> > I've manually minimized that to C below. AFAICT, that hits a leak, which
> > is what's triggering the OOM after the program is run a number of times
> > with the previously posted kvmalloc patch.
> > 
> > Per /proc/meminfo, that memory isn't accounted anywhere.
> > 
> >> Patch looks fine to me. Note
> >> that buffer registration is under the protection of RLIMIT_MEMLOCK.
> >> That's usually very limited for non-root, as root you can of course
> >> consume as much as you want and OOM the system.
> > 
> > Sure.
> > 
> > As above, it looks like there's a leak, regardless.
> 
> The leak is that we're not releasing imu->bvec in case of error. I fixed
> a missing kfree -> kvfree as well in your patch, with this rolled up
> version it works for me.

That works for me too.

I'll fold that into v2, and send that out momentarily.

Thanks,
Mark.
