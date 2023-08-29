Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA25778CDEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240570AbjH2U7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbjH2U6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:58:54 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9719A1BC;
        Tue, 29 Aug 2023 13:58:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F197D623489A;
        Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Y3sq38MqC2IP; Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8F80A6234894;
        Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dWL4oQjI8eUY; Tue, 29 Aug 2023 22:58:46 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (84-115-238-89.cable.dynamic.surfer.at [84.115.238.89])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id F2D166418DB0;
        Tue, 29 Aug 2023 22:58:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     alx@kernel.org, serge@hallyn.com, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com
Cc:     acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/3] Document impact of user namespaces and negative permissions
Date:   Tue, 29 Aug 2023 22:58:30 +0200
Message-Id: <20230829205833.14873-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm sending out this patch series to document the current situation regar=
ding
negative permissions and user namespaces.

From what I understand, the general agreement is that negative permission=
s
are not recommended and should be avoided. This is why the ability to som=
ewhat
bypass these permissions using user namespaces is tolerated, as it's deem=
ed
not worth the complexity to address this without breaking exsting program=
s such
as podman.

To be clear, the current way of bypassing negative permissions, whether D=
AC or
ACL, isn't a result of a kernel flaw. The kernel issue related to this wa=
s
resolved with CVE-2014-8989. Currently, certain privileged helpers like
newuidmap allow regular users to create user namespaces with subordinate =
user
and group ID mappings.
This allows users to effectively drop their extra group memberships.

I recently stumbled upon this behavior while looking into how rootless co=
ntainers
work. In conversations with the maintainers of the shadow package, I lear=
ned that
this behavior is both known and intended.
So, let's make sure to document it as well.

Thanks,
//richard

--=20
2.26.2

