Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE423D051
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgHERBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 13:01:19 -0400
Received: from namei.org ([65.99.196.166]:57602 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgHERAT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:00:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 075Gxe6x030131;
        Wed, 5 Aug 2020 16:59:42 GMT
Date:   Wed, 5 Aug 2020 09:59:40 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, zohar@linux.ibm.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com, paul@paul-moore.com,
        corbet@lwn.net, nramas@linux.microsoft.com, serge@hallyn.com,
        pasha.tatashin@soleen.com, jannh@google.com,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, mdsakib@microsoft.com,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
In-Reply-To: <1596639689.3457.17.camel@HansenPartnership.com>
Message-ID: <alpine.LRH.2.21.2008050934060.28225@namei.org>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>  <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>  <20200802143143.GB20261@amd>  <1596386606.4087.20.camel@HansenPartnership.com>  <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 5 Aug 2020, James Bottomley wrote:

> I'll leave Mimi to answer, but really this is exactly the question that
> should have been asked before writing IPE.  However, since we have the
> cart before the horse, let me break the above down into two specific
> questions.

The question is valid and it was asked. We decided to first prototype what 
we needed and then evaluate if it should be integrated with IMA. We 
discussed this plan in person with Mimi (at LSS-NA in 2019), and presented 
a more mature version of IPE to LSS-NA in 2020, with the expectation that 
such a discussion may come up (it did not).

These patches are still part of this process and 'RFC' status.

>    1. Could we implement IPE in IMA (as in would extensions to IMA cover
>       everything).  I think the answers above indicate this is a "yes".

It could be done, if needed.

>    2. Should we extend IMA to implement it?  This is really whether from a
>       usability standpoint two seperate LSMs would make sense to cover the
>       different use cases.

One issue here is that IMA is fundamentally a measurement & appraisal 
scheme which has been extended to include integrity enforcement. IPE was 
designed from scratch to only perform integrity enforcement. As such, it 
is a cleaner design -- "do one thing and do it well" is a good design 
pattern.

In our use-case, we utilize _both_ IMA and IPE, for attestation and code 
integrity respectively. It is useful to be able to separate these 
concepts. They really are different:

- Code integrity enforcement ensures that code running locally is of known 
provenance and has not been modified prior to execution.

- Attestation is about measuring the health of a system and having that 
measurement validated by a remote system. (Local attestation is useless).

I'm not sure there is value in continuing to shoe-horn both of these into 
IMA.


>  I've got to say the least attractive thing
>       about separation is the fact that you now both have a policy parser.
>        You've tried to differentiate yours by making it more Kconfig
>       based, but policy has a way of becoming user space supplied because
>       the distros hate config options, so I think you're going to end up
>       with a policy parser very like IMAs.


-- 
James Morris
<jmorris@namei.org>

