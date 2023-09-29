Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3D7B2F1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjI2JZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjI2JY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:24:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5C3195;
        Fri, 29 Sep 2023 02:24:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02AB0210E3;
        Fri, 29 Sep 2023 09:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695979496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwJNaqVDmwldOCtStU9d+TJN2bzEf6DW26tdoY+2mQ4=;
        b=OBetGxFQ20zzYL9rbnS98ddkfu+/g6TUeK2ef0CQXhmJ9pM35ZzdDYdTqt21zcwwsjl7kS
        BC0w13QeHt8ctN7gPTL+ArNMABDAfe6YahBMcyerYM3xmG6QKGZ4Mj5yDw1zfOK9qW78fS
        O3DBQlmEb0t7X2adk5YHIfWqUnQiWHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695979496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwJNaqVDmwldOCtStU9d+TJN2bzEf6DW26tdoY+2mQ4=;
        b=uE8yC0u2N6/sO/KrjTd0maYKp7Radm6dmhBDLvySml2ny8IVhW33QFF4CtfWTqgAjtSdlZ
        whnd6fcpW9aczdCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F8E41390A;
        Fri, 29 Sep 2023 09:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QRIbIOeXFmVmCAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 29 Sep 2023 09:24:55 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 5e485d82;
        Fri, 29 Sep 2023 09:24:54 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] fs: simplify misleading code to remove ambiguity
 regarding ihold()/iput()
In-Reply-To: <20230928-zecken-werkvertrag-59ae5e5044de@brauner> (Christian
        Brauner's message of "Thu, 28 Sep 2023 18:21:58 +0200")
References: <20230928152341.303-1-lhenriques@suse.de>
        <20230928-zecken-werkvertrag-59ae5e5044de@brauner>
Date:   Fri, 29 Sep 2023 10:24:54 +0100
Message-ID: <87il7tz5zt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

Christian Brauner <brauner@kernel.org> writes:

> On Thu, 28 Sep 2023 16:23:41 +0100, Lu=C3=ADs Henriques wrote:
>> Because 'inode' is being initialised before checking if 'dentry' is nega=
tive
>> it looks like an extra iput() on 'inode' may happen since the ihold() is
>> done only if the dentry is *not* negative.  In reality this doesn't happ=
en
>> because d_is_negative() is never true if ->d_inode is NULL.  This patch =
only
>> makes the code easier to understand, as I was initially mislead by it.
>>=20
>>=20
>> [...]
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/1] fs: simplify misleading code to remove ambiguity regarding ihold()/=
iput()
>       https://git.kernel.org/vfs/vfs/c/5c29bcfaa4cf

Could you please double-check this was indeed applied?  I can't see it
anywhere.  Maybe I'm looking at the wrong place, but since your scripts
seem to have messed-up my email address, something else may have went
wrong.

Cheers,
--=20
Lu=C3=ADs
