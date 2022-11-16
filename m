Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D30F62C69A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiKPRny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPRnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:43:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE1205EF;
        Wed, 16 Nov 2022 09:43:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8C93B81E2F;
        Wed, 16 Nov 2022 17:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD2EC433C1;
        Wed, 16 Nov 2022 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668620629;
        bh=2Rr069LAz98mXWOCBRygJOpq9srh9YH+T/Kx1QG1dcI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YuC832qSDYiB2R+JDhGGQZFQDZJ4IzVPMcRVI44YJFUcH6ZkChzqKqU/qNP6DKHf4
         wnj7NdYS6oXel8SucaJKh4mbbZ6CcYSpY6CNbn/dBBkFJPDwG/gq0wNkHFomZhhzRy
         uxc+FhSTEz2ONm1ASwbyUu4/ul9pGgFFIErESrhOewZfHaDXdudI9EpG/WR2GM6VLe
         jRofzCFMT/OdbceRmCNL5+H00EO+t5uv8FzxIBhwvdRALidFYhwuv3Va9lVnJgnWaS
         SY6LnePRO1lqFs+ZGzzDbY9+V2HbZoE6zn+325necCurg1oTIHKa32WLv+/QHfyV4k
         AbdBjWihX608Q==
Message-ID: <e51e721d09fb875c52247d71051728a6bfd0ab97.camel@kernel.org>
Subject: Re: [PATCH 1/7] filelock: add a new locks_inode_context accessor
 function
From:   Jeff Layton <jlayton@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        chuck.lever@oracle.com, viro@zeniv.linux.org.uk, hch@lst.de
Date:   Wed, 16 Nov 2022 12:43:47 -0500
In-Reply-To: <Y3ULBXgnUvt4amrc@infradead.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
         <20221116151726.129217-2-jlayton@kernel.org>
         <Y3ULBXgnUvt4amrc@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-11-16 at 08:08 -0800, Christoph Hellwig wrote:
> On Wed, Nov 16, 2022 at 10:17:20AM -0500, Jeff Layton wrote:
> > -	ctx =3D  smp_load_acquire(&inode->i_flctx);
> > +	ctx =3D  locks_inode_context(inode);
>=20
> Nit: this might be a good time to drop the weird double space here.
>=20
> Otherwise looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Fixed the nit in my tree.

After sending this, I converted locks_remove_file to use the helper too.
I also think we probably need to use this helper in
locks_free_lock_context.

Folded all 3 changes into this patch, and pushed to my linux-next feeder
branch.

Thanks Christoph!
--=20
Jeff Layton <jlayton@kernel.org>
