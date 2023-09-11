Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44A79BD37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbjIKU5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjIKKu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11675E9;
        Mon, 11 Sep 2023 03:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD08AC433C9;
        Mon, 11 Sep 2023 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694429424;
        bh=5eCOHpwInPjQA6NxPDr5kZtgwrG8Hy+L9RSiIjoYzXQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=I63fO3Oped5CcoSGIlghzn65dDLDS3AgXMOjiToNZvSUdrhpid8dA2fwnZ3L0uvuQ
         vRO43uNZPPKAjLBYaxKuEpPRCi/DBPQ5JahZ+/xplfXgFn+m6+K1DVaoMVszFQn7e3
         c/7ShNyPjBTDlCTah8S2O9CnI6mNmrRR5K25WKyBtu4HXfsGlCg1Nmd2cAEeAGJtqk
         +Xaszsx6GIBzt4dpxcFYC1VW/aJEKgOxHSFW2mvoY/oVjBtFiZDYuvh56WBy8I8ZL6
         aLRIobdGSMWYlt8ZweMRDuHBYUhcsbpwXJ23mEyEwkNhh06xFKUyD5SbyXxtBFA6QG
         oJalfh9jeUlHA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Sep 2023 13:50:18 +0300
Message-Id: <CVG13KLCIT1X.1MQT6HYAYFRAU@suppilovahvero>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <selinux@vger.kernel.org>,
        "Roberto Sassu" <roberto.sassu@huawei.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 11/25] security: Align inode_setattr hook definition
 with EVM
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Casey Schaufler" <casey@schaufler-ca.com>,
        "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
        <kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <dhowells@redhat.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>
X-Mailer: aerc 0.14.0
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831104136.903180-12-roberto.sassu@huaweicloud.com>
 <CVAFV92MONCH.257Y9YQ3OEU4B@suppilovahvero>
 <19943e35-2e7c-d27a-1a5d-189eea439dfd@schaufler-ca.com>
In-Reply-To: <19943e35-2e7c-d27a-1a5d-189eea439dfd@schaufler-ca.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue Sep 5, 2023 at 6:56 PM EEST, Casey Schaufler wrote:
> On 9/4/2023 2:08 PM, Jarkko Sakkinen wrote:
> > On Thu Aug 31, 2023 at 1:41 PM EEST, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Add the idmap parameter to the definition, so that evm_inode_setattr()=
 can
> >> be registered as this hook implementation.
> >>
> >> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h | 3 ++-
> >>  security/security.c           | 2 +-
> >>  security/selinux/hooks.c      | 3 ++-
> >>  security/smack/smack_lsm.c    | 4 +++-
> >>  4 files changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_de=
fs.h
> >> index 4bdddb52a8fe..fdf075a6b1bb 100644
> >> --- a/include/linux/lsm_hook_defs.h
> >> +++ b/include/linux/lsm_hook_defs.h
> >> @@ -134,7 +134,8 @@ LSM_HOOK(int, 0, inode_readlink, struct dentry *de=
ntry)
> >>  LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct ino=
de *inode,
> >>  	 bool rcu)
> >>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
> >> -LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *=
attr)
> >> +LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentr=
y *dentry,
> >> +	 struct iattr *attr)
> > LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry =
*dentry, struct iattr *attr)
> >
> > Only 99 characters, i.e. breaking into two lines is not necessary.
>
> We're keeping the LSM code in the ancient 80 character format.
> Until we get some fresh, young maintainers involved who can convince
> us that line wrapped 80 character terminals are kewl we're sticking
> with what we know.
>
> 	https://lwn.net/Articles/822168/

Pretty artificial counter-example tbh :-) Even with Rust people tend to
stick one character variable names for trivial integer indices.

BR, Jarkko
