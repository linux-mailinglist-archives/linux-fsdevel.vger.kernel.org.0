Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C122C7A1AE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjIOJl2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjIOJlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:41:19 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F1271C;
        Fri, 15 Sep 2023 02:40:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rn84T1Yt9z9xqnp;
        Fri, 15 Sep 2023 17:28:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAHXrlkJgRlA3tfAA--.51551S2;
        Fri, 15 Sep 2023 10:40:02 +0100 (CET)
Message-ID: <a0913021426ead2fc5e2a3db013335a67cdd4322.camel@huaweicloud.com>
Subject: Re: [PATCH v3 25/25] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 15 Sep 2023 11:39:44 +0200
In-Reply-To: <82486de4-2917-afb6-2ae3-6ea7f1346dc0@linux.ibm.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
         <20230904134049.1802006-6-roberto.sassu@huaweicloud.com>
         <82486de4-2917-afb6-2ae3-6ea7f1346dc0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwAHXrlkJgRlA3tfAA--.51551S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15tFWxGr47CFW7try7KFg_yoW8Kr4DpF
        4SgayUJw1Dtryvkr4vvFW5urWSgayjgayUWrn0k3WkZr95Zr1YgF45ury09FyUGrWrtw10
        qr4j9ry7Z3WDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj4-wdgABs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-12 at 12:19 -0400, Stefan Berger wrote:
> On 9/4/23 09:40, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Before the security field of kernel objects could be shared among LSMs with
> > the LSM stacking feature, IMA and EVM had to rely on an alternative storage
> > of inode metadata. The association between inode metadata and inode is
> > maintained through an rbtree.
> > 
> > With the reservation mechanism offered by the LSM infrastructure, the
> > rbtree is no longer necessary, as each LSM could reserve a space in the
> > security blob for each inode. Thus, request from the 'integrity' LSM a
> > space in the security blob for the pointer of inode metadata
> > (integrity_iint_cache structure).
> > 
> > Prefer this to allocating the integrity_iint_cache structure directly, as
> > IMA would require it only for a subset of inodes. Always allocating it
> > would cause a waste of memory.
> > 
> > Introduce two primitives for getting and setting the pointer of
> > integrity_iint_cache in the security blob, respectively
> > integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
> > the code more understandable, as they directly replace rbtree operations.
> > 
> > Locking is not needed, as access to inode metadata is not shared, it is per
> > inode.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> > 
> > @@ -145,10 +91,8 @@ static void integrity_inode_free(struct inode *inode)
> >   	if (!IS_IMA(inode))
> >   		return;
> 
> I think you can remove this check !IS_IMA()  as well since the next 
> function called here integrity_iint_find() already has this check:
> 
> struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
> {
>          if (!IS_IMA(inode))
>                  return NULL;
> 
>          return integrity_inode_get_iint(inode);
> }

I agree, thanks!

Roberto

> >   
> > -	write_lock(&integrity_iint_lock);
> > -	iint = __integrity_iint_find(inode);
> > -	rb_erase(&iint->rb_node, &integrity_iint_tree);
> > -	write_unlock(&integrity_iint_lock);
> > +	iint = integrity_iint_find(inode);         <--------------
> > +	integrity_inode_set_iint(inode, NULL);
> >   
> >   	iint_free(iint);
> >   }

