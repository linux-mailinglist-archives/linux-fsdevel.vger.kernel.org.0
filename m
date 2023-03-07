Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5301D6AD9BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 09:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCGI65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 03:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCGI6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:58:55 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E7515F7;
        Tue,  7 Mar 2023 00:58:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PW8KD3lV2z9yB6h;
        Tue,  7 Mar 2023 16:50:08 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwC3gVio_AZktq14AQ--.19560S2;
        Tue, 07 Mar 2023 09:58:29 +0100 (CET)
Message-ID: <f604ce5c7a535755a56736395a82220f65bcbc3f.camel@huaweicloud.com>
Subject: Re: [PATCH 11/28] evm: Complete description of evm_inode_setattr()
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
Date:   Tue, 07 Mar 2023 09:58:14 +0100
In-Reply-To: <ecb168e5-e85f-73ee-7bc4-c13d0ea8811e@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-12-roberto.sassu@huaweicloud.com>
         <ecb168e5-e85f-73ee-7bc4-c13d0ea8811e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwC3gVio_AZktq14AQ--.19560S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkJF48Xr4UCFyUAr45GFg_yoW8XF13pa
        yfKa48Gr4rtry29F98ta1xZa4Sg3y0gryj9398Aw4qyFn8GrnavryIkryrur98Kr18Cr1F
        ya4av3W3Za15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4pFJgACsW
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-03-06 at 12:04 -0500, Stefan Berger wrote:
> 
> On 3/3/23 13:18, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add the description for missing parameters of evm_inode_setattr() to
> > avoid the warning arising with W=n compile option.
> > 
> > Fixes: 817b54aa45db ("evm: add evm_inode_setattr to prevent updating an invalid security.evm")
> > Fixes: c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Among the previous patches I think there were 2 fixes like this one you could possibly also split off.

Didn't find it.

Thanks

Roberto

> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >   security/integrity/evm/evm_main.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 1155a58ae87..8b5c472f78b 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -798,7 +798,9 @@ static int evm_attr_change(struct mnt_idmap *idmap,
> >   
> >   /**
> >    * evm_inode_setattr - prevent updating an invalid EVM extended attribute
> > + * @idmap: idmap of the mount
> >    * @dentry: pointer to the affected dentry
> > + * @attr: iattr structure containing the new file attributes
> >    *
> >    * Permit update of file attributes when files have a valid EVM signature,
> >    * except in the case of them having an immutable portable signature.

