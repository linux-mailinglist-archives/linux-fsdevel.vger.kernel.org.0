Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B257A119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiGSOSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiGSOSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:18:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C11823BC;
        Tue, 19 Jul 2022 06:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D08D5B81B8D;
        Tue, 19 Jul 2022 13:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C4FC341CB;
        Tue, 19 Jul 2022 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658238695;
        bh=QeJAInDIAJS0bLSuxg3SAOrNlCEwmo7FtjC5iNw55Cc=;
        h=Subject:From:To:Cc:Date:From;
        b=NByfDd0VTuQejMs7cFfZb+YnuLYZqh4cuTBui2YfKAyY+Fsd5qoN17Ay19jQ/fEXb
         ZmwvYlspN8yOA7rMIj5mJ60bcqyq13tUPv6IDGFyFlYuWm3vHOj7CtUsyi9QSXnwX/
         LZlGZ96Ehol1ZsCKhVD7frWZRwkroJAQ4W4SlfRMHpMqhvAiHqP4RFAodFsYDERVUE
         7BAqL4HEzPVWcN67poka6etAJ9isBl2E4LmLlOkByN8EjQqlp2EPsYfY8BdsDB2HX8
         is76RIwC4u+kM52uqkYur4ztvuxb7nUarUmU7rcmwcNqLZXLV5TFKdT2VER1gs1yw2
         JX4TR3/7HIufg==
Message-ID: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
Subject: should we make "-o iversion" the default on ext4 ?
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com, Benjamin Coddington <bcodding@redhat.com>
Date:   Tue, 19 Jul 2022 09:51:33 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Back in 2018, I did a patchset [1] to rework the inode->i_version
counter handling to be much less expensive, particularly when no-one is
querying for it.

Testing at the time showed that the cost of enabling i_version on ext4
was close to 0 when nothing is querying it, but I stopped short of
trying to make it the default at the time (mostly out of an abundance of
caution). Since then, we still see a steady stream of cache-coherency
problems with NFSv4 on ext4 when this option is disabled (e.g. [2]).

Is it time to go ahead and make this option the default on ext4? I don't
see a real downside to doing so, though I'm unclear on how we should
approach this. Currently the option is twiddled using MS_I_VERSION flag,
and it's unclear to me how we can reverse the sense of such a flag.

Thoughts?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Da4b7fd7d34de5765dece2dd08060d2e1f7be3b39
[2]: https://bugzilla.redhat.com/show_bug.cgi?id=3D2107587

--=20
Jeff Layton <jlayton@kernel.org>
