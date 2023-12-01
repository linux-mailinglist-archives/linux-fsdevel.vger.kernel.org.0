Return-Path: <linux-fsdevel+bounces-4534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3858800199
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 03:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720182815CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36145882A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 1748 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 17:36:20 PST
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68973D50;
	Thu, 30 Nov 2023 17:36:20 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 3B115q1E009250;
	Thu, 30 Nov 2023 19:05:52 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 3B115nMV009249;
	Thu, 30 Nov 2023 19:05:49 -0600
Date: Thu, 30 Nov 2023 19:05:49 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed blob for integrity_iint_cache
Message-ID: <20231201010549.GA8923@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com> <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com> <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com> <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com> <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com> <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 30 Nov 2023 19:05:52 -0600 (CST)

On Wed, Nov 29, 2023 at 07:46:43PM +0100, Roberto Sassu wrote:

Good evening, I hope the week has gone well for everyone.

> On 11/29/2023 6:22 PM, Paul Moore wrote:
> >On Wed, Nov 29, 2023 at 7:28???AM Roberto Sassu
> ><roberto.sassu@huaweicloud.com> wrote:
> >>
> >>On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
> >>>On Mon, Nov 20, 2023 at 3:16???AM Roberto Sassu
> >>><roberto.sassu@huaweicloud.com> wrote:
> >>>>On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> >>>>>On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >>>>>>
> >>>>>>Before the security field of kernel objects could be shared among 
> >>>>>>LSMs with
> >>>>>>the LSM stacking feature, IMA and EVM had to rely on an alternative 
> >>>>>>storage
> >>>>>>of inode metadata. The association between inode metadata and inode is
> >>>>>>maintained through an rbtree.
> >>>>>>
> >>>>>>Because of this alternative storage mechanism, there was no need to 
> >>>>>>use
> >>>>>>disjoint inode metadata, so IMA and EVM today still share them.
> >>>>>>
> >>>>>>With the reservation mechanism offered by the LSM infrastructure, the
> >>>>>>rbtree is no longer necessary, as each LSM could reserve a space in 
> >>>>>>the
> >>>>>>security blob for each inode. However, since IMA and EVM share the
> >>>>>>inode metadata, they cannot directly reserve the space for them.
> >>>>>>
> >>>>>>Instead, request from the 'integrity' LSM a space in the security 
> >>>>>>blob for
> >>>>>>the pointer of inode metadata (integrity_iint_cache structure). The 
> >>>>>>other
> >>>>>>reason for keeping the 'integrity' LSM is to preserve the original 
> >>>>>>ordering
> >>>>>>of IMA and EVM functions as when they were hardcoded.
> >>>>>>
> >>>>>>Prefer reserving space for a pointer to allocating the 
> >>>>>>integrity_iint_cache
> >>>>>>structure directly, as IMA would require it only for a subset of 
> >>>>>>inodes.
> >>>>>>Always allocating it would cause a waste of memory.
> >>>>>>
> >>>>>>Introduce two primitives for getting and setting the pointer of
> >>>>>>integrity_iint_cache in the security blob, respectively
> >>>>>>integrity_inode_get_iint() and integrity_inode_set_iint(). This would 
> >>>>>>make
> >>>>>>the code more understandable, as they directly replace rbtree 
> >>>>>>operations.
> >>>>>>
> >>>>>>Locking is not needed, as access to inode metadata is not shared, it 
> >>>>>>is per
> >>>>>>inode.
> >>>>>>
> >>>>>>Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>>>>>Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>>>>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>>>>>---
> >>>>>>  security/integrity/iint.c      | 71 
> >>>>>>  +++++-----------------------------
> >>>>>>  security/integrity/integrity.h | 20 +++++++++-
> >>>>>>  2 files changed, 29 insertions(+), 62 deletions(-)
> >>>>>>
> >>>>>>diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> >>>>>>index 882fde2a2607..a5edd3c70784 100644
> >>>>>>--- a/security/integrity/iint.c
> >>>>>>+++ b/security/integrity/iint.c
> >>>>>>@@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> >>>>>>     return 0;
> >>>>>>  }
> >>>>>>
> >>>>>>+struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
> >>>>>>+   .lbs_inode = sizeof(struct integrity_iint_cache *),
> >>>>>>+};
> >>>>>
> >>>>>I'll admit that I'm likely missing an important detail, but is there
> >>>>>a reason why you couldn't stash the integrity_iint_cache struct
> >>>>>directly in the inode's security blob instead of the pointer?  For
> >>>>>example:
> >>>>>
> >>>>>   struct lsm_blob_sizes ... = {
> >>>>>     .lbs_inode = sizeof(struct integrity_iint_cache),
> >>>>>   };
> >>>>>
> >>>>>   struct integrity_iint_cache *integrity_inode_get(inode)
> >>>>>   {
> >>>>>     if (unlikely(!inode->isecurity))
> >>>>>       return NULL;
> >>>>>     return inode->i_security + integrity_blob_sizes.lbs_inode;
> >>>>>   }
> >>>>
> >>>>It would increase memory occupation. Sometimes the IMA policy
> >>>>encompasses a small subset of the inodes. Allocating the full
> >>>>integrity_iint_cache would be a waste of memory, I guess?
> >>>
> >>>Perhaps, but if it allows us to remove another layer of dynamic memory
> >>>I would argue that it may be worth the cost.  It's also worth
> >>>considering the size of integrity_iint_cache, while it isn't small, it
> >>>isn't exactly huge either.
> >>>
> >>>>On the other hand... (did not think fully about that) if we embed the
> >>>>full structure in the security blob, we already have a mutex available
> >>>>to use, and we don't need to take the inode lock (?).
> >>>
> >>>That would be excellent, getting rid of a layer of locking would be 
> >>>significant.
> >>>
> >>>>I'm fully convinced that we can improve the implementation
> >>>>significantly. I just was really hoping to go step by step and not
> >>>>accumulating improvements as dependency for moving IMA and EVM to the
> >>>>LSM infrastructure.
> >>>
> >>>I understand, and I agree that an iterative approach is a good idea, I
> >>>just want to make sure we keep things tidy from a user perspective,
> >>>i.e. not exposing the "integrity" LSM when it isn't required.
> >>
> >>Ok, I went back to it again.
> >>
> >>I think trying to separate integrity metadata is premature now, too
> >>many things at the same time.
> >
> >I'm not bothered by the size of the patchset, it is more important
> >that we do The Right Thing.  I would like to hear in more detail why
> >you don't think this will work, I'm not interested in hearing about
> >difficult it may be, I'm interested in hearing about what challenges
> >we need to solve to do this properly.
> 
> The right thing in my opinion is to achieve the goal with the minimal 
> set of changes, in the most intuitive way.
> 
> Until now, there was no solution that could achieve the primary goal of 
> this patch set (moving IMA and EVM to the LSM infrastructure) and, at 
> the same time, achieve the additional goal you set of removing the 
> 'integrity' LSM.
> 
> If you see the diff, the changes compared to v5 that was already 
> accepted by Mimi are very straightforward. If the assumption I made that 
> in the end the 'ima' LSM could take over the role of the 'integrity' 
> LSM, that for me is the preferable option.
> 
> Given that the patch set is not doing any design change, but merely 
> moving calls and storing pointers elsewhere, that leaves us with the 
> option of thinking better what to do next, including like you suggested 
> to make IMA and EVM use disjoint metadata.

A suggestion has been made in this thread that there needs to be broad
thinking on this issue, and by extension, other tough problems.  On
that note, we would be interested in any thoughts regarding the notion
of a long term solution for this issue being the migration of EVM to a
BPF based implementation?

There appears to be consensus that the BPF LSM will always go last, a
BPF implementation would seem to address the EVM ordering issue.

In a larger context, there have been suggestions in other LSM threads
that BPF is the future for doing LSM's.  Coincident with that has come
some disagreement about whether or not BPF embodies sufficient
functionality for this role.

The EVM codebase is reasonably modest with a very limited footprint of
hooks that it handles.  A BPF implementation on this scale would seem
to go a long ways in placing BPF sufficiency concerns to rest.

Thoughts/issues?

> Thanks
> 
> Roberto

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

