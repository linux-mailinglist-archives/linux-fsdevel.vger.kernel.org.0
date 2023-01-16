Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B866BDFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 13:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjAPMjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 07:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjAPMjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A541E28C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 04:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673872726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vMC7IzmlZ9zyaSEbvkpVXyZRZpRHzxrTjtlIuL9e/AE=;
        b=UVJvy+6arGXK1Ybv+WpUUAVO8TJ/NVFRSQTC2KUxbt3p8nNkbBPniOiDhZcWzKIW9m3DP+
        7lFkzUz9lcKQ1YQ920cchjg1tGbpTSbxw3bRf3hMHWoE2DEklvAl1CsK8pSY5NcsmwAEJw
        jfj+fWTmUjMx3FmrEI4+/Rig/fJFVgU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-sA5ERL_wP62H7V3aoCBqDA-1; Mon, 16 Jan 2023 07:38:40 -0500
X-MC-Unique: sA5ERL_wP62H7V3aoCBqDA-1
Received: by mail-lj1-f198.google.com with SMTP id c18-20020a2ebf12000000b00279a72705feso7434302ljr.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 04:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMC7IzmlZ9zyaSEbvkpVXyZRZpRHzxrTjtlIuL9e/AE=;
        b=KTGvQdy8jFRDfDx2WoFUNSCeVGJbBkQZu3yI4OV4WAc8nw18o2hGU5iFcvtETA3fve
         lH7gb1oNwrix8JrAm5h7IuDCIdlWfb9wmeWZcpz1RZXy12sp/4E9vJsW0Haf6lKvc6k2
         lTJ0p3UvI4DN8NCehlLal67pYVqNuwBqThrjE75tbG1PKm47KCnc743uA0R53vPphCBq
         d9hn27DFKHCnRDHH2us3y780Em2Y2X7cxspMPlLwWkQtINPV2TcGLNUT0rFYUA/vWyL4
         oxWI1cAEf8PPoBmUbXGQI/K6hWCW5OvzVAaV/STqul1UazXRC0yxfDEpk/Fds57iSxtn
         LCSA==
X-Gm-Message-State: AFqh2kq+v0JioxeWkFYZ4z0cO+scse2FwFEVO2juGdC4XJX80CwSsa4m
        dS3B05NGmLsLxciluBrcWBBIrdn60ZsFeqM7XUo+yNbFgZGYyeRJaWj621PCTdHTWa+1NHNmh5N
        JQvF7xP2QiiLt3q6SDN7E2xQwnA==
X-Received: by 2002:a19:f514:0:b0:4b5:61e8:8934 with SMTP id j20-20020a19f514000000b004b561e88934mr23410956lfb.64.1673872716357;
        Mon, 16 Jan 2023 04:38:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtbtG8HGa47c9RU6K67MGza9pSGgqJZjaJyrdKqUM9S/apI57wVq1SaCwnjhvFPrXq7JWidYA==
X-Received: by 2002:a19:f514:0:b0:4b5:61e8:8934 with SMTP id j20-20020a19f514000000b004b561e88934mr23410947lfb.64.1673872716156;
        Mon, 16 Jan 2023 04:38:36 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm5027673lfe.201.2023.01.16.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:38:35 -0800 (PST)
Message-ID: <d81a67c489eee5f045939db24cbdd6984ad3d030.camel@redhat.com>
Subject: Re: [PATCH v2 5/6] composefs: Add documentation
From:   Alexander Larsson <alexl@redhat.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        linux-doc@vger.kernel.org
Date:   Mon, 16 Jan 2023 13:38:35 +0100
In-Reply-To: <Y8IffF7xjyX6BzUE@debian.me>
References: <cover.1673623253.git.alexl@redhat.com>
         <a9616059dd7d094c2756cb426e29ce2ac7d8e998.1673623253.git.alexl@redhat.com>
         <Y8IffF7xjyX6BzUE@debian.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-01-14 at 10:20 +0700, Bagas Sanjaya wrote:
> On Fri, Jan 13, 2023 at 04:33:58PM +0100, Alexander Larsson wrote:
> > Adds documentation about the composefs filesystem and
> > how to use it.
>=20
> s/Adds documentation/Add documentation/
>=20

Thanks, I'll apply your proposals in the next version.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a shy pirate astronaut on his last day in the job. She's a plucky=20
paranoid museum curator with an MBA from Harvard. They fight crime!=20

