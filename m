Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6675AF068
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 18:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiIFQbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiIFQbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:31:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E061AD83;
        Tue,  6 Sep 2022 09:03:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 108E5B81604;
        Tue,  6 Sep 2022 16:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7F5C433D6;
        Tue,  6 Sep 2022 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662480178;
        bh=FMYRZ0ogLlueEYXP4JG30FH8Q9HpHmij/Ejx+UQ4AXo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T+EmDN+BtZcLf/du1cxdlgshB6cr0YWlKAyXAUEFy8L+zlIEQ6D+QrX3W3a688eGL
         2sV8BNCO0pODeH4IaisrhIotHxY2Dcwt6CAbjXclw/AzIINPrp3trfNrKoIawHMYbh
         oUEE195garRlFPZ6oMGgQT2IgtTRn3Z1BaIynTpM+dNZ/aXH9mrfAlJjygn/jHnke/
         gWZtq95BCvzK4CjTnkjLOnG2c6qRD66WCyyAJUgXLeiA4iTijVLOZlUtTQ6X+wkPN5
         lRshuExOWRzEKmk+vPmqMbsjhFNvJFyLfYnz/PQaFYFULAXPbCMupLdmn85Kq9MqSv
         U82YgXH0FjC8A==
Message-ID: <93ff2f6d8c49091c0aa8a008695da5150c096be3.camel@kernel.org>
Subject: Re: [PATCH v5] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Sep 2022 12:02:55 -0400
In-Reply-To: <3349244.1662480110@warthog.procyon.org.uk>
References: <7a154687f8be9d7a2365ae4a93f2b7f734002904.camel@kernel.org>
         <217595.1662033775@warthog.procyon.org.uk>
         <3349244.1662480110@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-09-06 at 17:01 +0100, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > If this or the other allocations below fail, do you need to free the
> > prior ones here? Or do they automagically get cleaned up somehow?
>=20
> Once the fs_context is allocated, it will always get cleaned up with
> put_fs_context(), which will dispose of the partially constructed
> smack_mnt_opts struct.
>=20


Ok! In that case, you can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
