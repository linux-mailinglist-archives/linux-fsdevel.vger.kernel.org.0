Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CFD736B7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 14:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjFTMCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjFTMCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD68E71;
        Tue, 20 Jun 2023 05:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA9E61203;
        Tue, 20 Jun 2023 12:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9840C433C8;
        Tue, 20 Jun 2023 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687262567;
        bh=GXe5B4aYQ4ma9uMJ45jDojtdJ5CPVGntQWffBVb71Sg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bcsrizIOal+rp+9XGHpRC/IAyqdamxFHoG1FdlthzjBB83ZKFst+pYmmHitQVjoBp
         DQFAbJXkrQOIpuIV9yKnXce1XVP0hw28kdEzDVsqJdOoAm3xxCYUJep8+SSpbdsBcY
         VIdlMv4lHaEiv58YN/6aE+h2QP9ztFZ3PtNjgbfvr2O+3IvR8+Q30Suw+Ky4zQ4BYk
         4YBxvMVcJ4F/b76JexMvOOpzaaWpCP9LytaLkB2wCg7nlB+Q7FFbJiaDXDXdV1cs+0
         0lsOADQg3dCHsgaz+43TGbgAEINWXjZgDG4nxDQprgntx/uh63QIKaYCDRiGQgvVjd
         Zm2AAmwaYX76w==
Message-ID: <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
From:   Jeff Layton <jlayton@kernel.org>
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 20 Jun 2023 08:02:45 -0400
In-Reply-To: <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
References: <20230620095507.2677463-1-stsp2@yandex.ru>
         <20230620095507.2677463-3-stsp2@yandex.ru>
         <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
         <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
         <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
         <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-06-20 at 16:45 +0500, stsp wrote:
> 20.06.2023 16:12, Jeff Layton =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Multithreaded processes are also a bit of a gray area here: Suppose I
> > open a file and set an OFD lock on it in one task, and then let that
> > task exit while the file is still open. What should l_pid say in that
> > case?
>=20
> If by the "task" you mean a process, then
> the result should be no lock at all.
> If you mean the thread exit, then I would
> expect l_pid to contain tgid, in which case
> it will still point to the valid pid.
> Or do you mean l_pid contains tid?
> Checking... no, l_pid contains tgid.
> So I don't really see the problem you are
> pointing with the above example, could
> you please clarify?
>=20

Suppose I start a process (call it pid 100), and then spawn a thread
(101). I then have 101 open a file and set an OFD lock on it (such that
the resulting fl_pid field in the file_lock is set to 101). Now, join
the thread so that task 101 exits.

Wait a while, and eventually pid 101 will be recycled, so that now there
is a new task 101 that is unrelated to the process above. Another
(unrelated) task then calls F_GETLK on the file and sees that lock. Its
pid is now set to 101 and sends SIGKILL to it, killing an unrelated
process.

That's just one example, of course. The underlying problem is that OFD
locks are not owned by processes in the same way that traditional POSIX
locks are, so reporting a pid there is unreliable, at best.
--=20
Jeff Layton <jlayton@kernel.org>
