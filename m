Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C516AC594
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 16:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjCFPgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 10:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjCFPg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:36:27 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC237B4B;
        Mon,  6 Mar 2023 07:35:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PVj8P3kJJz9xrsC;
        Mon,  6 Mar 2023 23:25:57 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwA3wAvvBwZkGfJ3AQ--.19155S2;
        Mon, 06 Mar 2023 16:34:20 +0100 (CET)
Message-ID: <7bde74e6e5ccf24b2a2bd9dc2bbfcae5c424eac7.camel@huaweicloud.com>
Subject: Re: [PATCH 21/28] security: Introduce inode_post_remove_acl hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, viro@zeniv.linux.org.uk,
        chuck.lever@oracle.com, jlayton@kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 06 Mar 2023 16:34:04 +0100
In-Reply-To: <6393eb31-5eb3-cb1c-feb7-2ab347703042@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-22-roberto.sassu@huaweicloud.com>
         <6393eb31-5eb3-cb1c-feb7-2ab347703042@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwA3wAvvBwZkGfJ3AQ--.19155S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW5CrW7Ww47Gr43GrykXwb_yoWDurc_CF
        4vy3s7GFs8XF1kJr4q9r1FqFsa9rZ5XrnxtryrGrs8AayxJFn5WF4IyryfZrW8Xrn7A3y5
        AFyxAay2vFy7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4o+5gAEsq
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-03-06 at 10:22 -0500, Stefan Berger wrote:
> 
> On 3/3/23 13:18, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > the inode_post_remove_acl hook.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   
> > +/**
> > + * security_inode_post_remove_acl() - Update inode sec after remove_acl op
> > + * @idmap: idmap of the mount
> > + * @dentry: file
> > + * @acl_name: acl name
> > + *
> > + * Update inode security field after successful remove_acl operation on @dentry
> > + * in @idmap. The posix acls are identified by @acl_name.
> > + */
> > +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> > +				    struct dentry *dentry, const char *acl_name)
> > +{
> > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > +		return;
> 
> Was that a mistake before that EVM and IMA functions did not filtered out private inodes?

Looks like that. At least for hooks that are not called from
security.c.

Thanks

Roberto

