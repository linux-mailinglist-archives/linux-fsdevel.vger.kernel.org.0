Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE46D10AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 23:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjC3VRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjC3VRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:17:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2C919A6;
        Thu, 30 Mar 2023 14:17:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46306219C3;
        Thu, 30 Mar 2023 21:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680211053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDpjBQjPx/Cm6DB4FecJ0EA4XNsAu0nyZ0g7+LvXuic=;
        b=fSv8LA1kQQQhxKTvS6jzcSnbb51cz/MyciUpw7ICiNWNBed3fE0s3JQkQ6GS6B+2sj4x0z
        enWDBO1LU7Hdai+y4f3p3anvtICUah5RfpAYispxWpCfDc5Q2qsEabbY+DcIg2JrcNepSW
        T5m9IOrh4oLpM8FwWBUD+woG8XxjS+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680211053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDpjBQjPx/Cm6DB4FecJ0EA4XNsAu0nyZ0g7+LvXuic=;
        b=2XKtwizXGxkGw/dUw5fnR3rchsECyBf95u6Ix8oYpzPgTHoWYp1S+b769qTrfzHzmYpexP
        z304ldSj9qUrE2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17463133E0;
        Thu, 30 Mar 2023 21:17:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6ocIBG38JWSecgAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 30 Mar 2023 21:17:33 +0000
Date:   Thu, 30 Mar 2023 23:19:10 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cifs: fix DFS traversal oops without
 CONFIG_CIFS_DFS_UPCALL
Message-ID: <20230330231910.1bed68a1@echidna.fritz.box>
In-Reply-To: <CAH2r5mtEXtRWbtf9OAzwWa2Wm6fUR+fZrU=OmtiP3E0VQpn+2w@mail.gmail.com>
References: <20230329202406.15762-1-ddiss@suse.de>
        <CAH2r5mtEXtRWbtf9OAzwWa2Wm6fUR+fZrU=OmtiP3E0VQpn+2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

On Wed, 29 Mar 2023 18:20:33 -0500, Steve French wrote:

> merged into cifs-2.6.git for-next and added Paulo's Reviewed-by

Thanks, although I'm only aware of Ronnie's review (in this thread).

> On Wed, Mar 29, 2023 at 3:23=E2=80=AFPM David Disseldorp <ddiss@suse.de> =
wrote:
>=20
> > When compiled with CONFIG_CIFS_DFS_UPCALL disabled, cifs_dfs_d_automount
> > NULL. cifs.ko logic for mapping CIFS_FATTR_DFS_REFERRAL attributes to
    ^^
If you're fixing the reviewed-by, then please also add the missing
"is" between "cifs_dfs_d_automount NULL".

Cheers, David
