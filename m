Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985917A4C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjIRPcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjIRPbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:31:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634A62D64;
        Mon, 18 Sep 2023 08:30:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E44CC116A6;
        Mon, 18 Sep 2023 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695050546;
        bh=Jy81jZ+Pg9L8j4zgKk95bii6/t3Wa+sejLO3X5izIQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfYUdDD9s5k0zOMqYJk1cs4VUf+bhsU6YSfeQzPC5IWDI1JEtk1KhAX0qCwjbeod+
         9PSgK+jKcmA+0SWVJGmjc7MLI3jOy4IZZPILqRC4qxbmSqlrTlPTFArUkEmmKA3u4m
         Ai/6ZdP0QpzZmgN/zra7pQqij+CquNG1+4jPyrunwtd1CEHSWYBuvr8W/OP3kodFoF
         CZqwJxD+BA9av3Plub+f9noTCXflPGAh/ehP/HTcqlNTpCrkZQ/M2Klgry7PnQUUfj
         hJ2ZsoPwfhTKLK7hp8CPfkrSpPPuvbQsdR1+knQ1jVg6zYS3hbxhpNHdzyuG5UCey3
         PAFyK+1S+PQqA==
Date:   Mon, 18 Sep 2023 17:22:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner>
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
 <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
 <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner>
 <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> So to be clear about your proposal: .mnt_root and .mountpoint are
> initialized by the caller to buffers that the kernel can copy paths
> into?

Yeah, u64 pointer to a buffer and a size (see e.g., @set_tid and
@set_tid_size for struct clone_args, @log_buf and @log_size and other
args in there).

> 
> If there's an overflow (one of the buffers was too small) the syscall
> returns -EOVERFLOW?

Yeah, I mean we have to make some things their problem.

To me that is an acceptable compromise.
