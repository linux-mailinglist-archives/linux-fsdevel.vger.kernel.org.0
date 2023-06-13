Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8673172E632
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbjFMOth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbjFMOte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20C19B9;
        Tue, 13 Jun 2023 07:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7582F623E5;
        Tue, 13 Jun 2023 14:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC80C433D9;
        Tue, 13 Jun 2023 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686667771;
        bh=AhVPtPsy6zhd+dXGiGy9fkDadgJVED0C5Q7/7kZBerw=;
        h=From:Subject:Date:To:Cc:From;
        b=j2RQVKvAJM0LLkr4Yl5NJWVI6gv3vsMjYfroPX6rVhefd85oKrwAsNahmnEnPpLNT
         eVujIzUE1Nqpoye5oaFhtr0KpHD3O0eJFo5LjzdzX/kjjf+xuQl6tVkxH7lhL5iP20
         axbVtF/i85055at11pol9OHea3zYqvFlcwhBQwG2LNpSjaYrt9pyi+n811PFqhPfv0
         yz/Q1URYkblBe1S72CqqLlib1VNG3iTJaWeDxDB/CUpDsRgSM21ahjb2nSg+W+emzm
         pHOEhbY2Q/zyBW/mciaC4uILC3Rn48UaxTrBO4N0KaIGRZpF88U/U190RNC6gu3lqP
         fUQ0iEQEXBNRw==
From:   Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/3] ovl: port to new mount api & updated layer parsing
Date:   Tue, 13 Jun 2023 16:49:15 +0200
Message-Id: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuBiGQC/42OQQ6CMBBFr2K6dkwpKODKexhjhjKFRmxJiw2Ec
 HcLG+NKd/Mm8/6fmXlymjw772bmKGivrYmQ7ndMtmgaAl1HZoKLlJ/4EZQHG8h1OMXpaV9muGO
 vQXDCouIZKZWxKFfoCSqHRrar/lEMjcN60DtSetyar7fIrfaDddP2SEjW7c/OkEACWNR5IVNVE
 arLg5yh7mBdw9bMIP7LEcAhrbFMZJkTl/wrZ1mWNwZwziYmAQAA
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=10475; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AhVPtPsy6zhd+dXGiGy9fkDadgJVED0C5Q7/7kZBerw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR0NP7S+mqekWqyLFC71KjK53DUFL9zYtL/A5YpsiRcCH3R
 niLTUcLCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEF7xl+zPLfzegvUTRDfL181odpXz
 35zov+1DY9kaU2a1f6VOkWRob19a7WpnP7VzTMebr9sEFJdt2b+RaX1+5jDJ/A5nXoygk+AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

/* v3 */
(1) Add a patch that makes sure that struct ovl_layer starts with a
    pointer to struct vfsmount as ovl_free_fs() relies on this during
    cleanup.
(2) Rebase on top of overlayfs-next brought in substantial rework due to
    the data layer work. I had to redo a bunch of the parsing and adapt
    it to the new changes.

This ports overlayfs to the new mount api and modifies layer parsing to
allow for additive layer specification via fsconfig().

This passes xfstests including the new data layer lookup work. Here's a
500 layer overlayfs mount including a couple of data only layers:

1094 28 0:48 / /mnt/test rw,relatime shared:214 - overlay none rw,lowerdir=/mnt/ovl-lower1:/mnt/ovl-lower2:/mnt/ovl-lower3:/mnt/ovl-lower4:/mnt/ovl-lower5:/mnt/ovl-lower6:/mnt/ovl-lower7:/mnt/ovl-lower8:/mnt/ovl-lower9:/mnt/ovl-lower10:/mnt/ovl-lower11:/mnt/ovl-lower12:/mnt/ovl-lower13:/mnt/ovl-lower14:/mnt/ovl-lower15:/mnt/ovl-lower16:/mnt/ovl-lower17:/mnt/ovl-lower18:/mnt/ovl-lower19:/mnt/ovl-lower20:/mnt/ovl-lower21:/mnt/ovl-lower22:/mnt/ovl-lower23:/mnt/ovl-lower24:/mnt/ovl-lower25:/mnt/ovl-lower26:/mnt/ovl-lower27:/mnt/ovl-lower28:/mnt/ovl-lower29:/mnt/ovl-lower30:/mnt/ovl-lower31:/mnt/ovl-lower32:/mnt/ovl-lower33:/mnt/ovl-lower34:/mnt/ovl-lower35:/mnt/ovl-lower36:/mnt/ovl-lower37:/mnt/ovl-lower38:/mnt/ovl-lower39:/mnt/ovl-lower40:/mnt/ovl-lower41:/mnt/ovl-lower42:/mnt/ovl-lower43:/mnt/ovl-lower44:/mnt/ovl-lower45:/mnt/ovl-lower46:/mnt/ovl-lower47:/mnt/ovl-lower48:/mnt/ovl-lower49:/mnt/ovl-lower50:/mnt/ovl-lower51:/mnt/ovl-lower52:/mnt/ovl-lower53:/mnt/ovl-lower54:/mnt/ovl-lower
 55:/mnt/ovl-lower56:/mnt/ovl-lower57:/mnt/ovl-lower58:/mnt/ovl-lower59:/mnt/ovl-lower60:/mnt/ovl-lower61:/mnt/ovl-lower62:/mnt/ovl-lower63:/mnt/ovl-lower64:/mnt/ovl-lower65:/mnt/ovl-lower66:/mnt/ovl-lower67:/mnt/ovl-lower68:/mnt/ovl-lower69:/mnt/ovl-lower70:/mnt/ovl-lower71:/mnt/ovl-lower72:/mnt/ovl-lower73:/mnt/ovl-lower74:/mnt/ovl-lower75:/mnt/ovl-lower76:/mnt/ovl-lower77:/mnt/ovl-lower78:/mnt/ovl-lower79:/mnt/ovl-lower80:/mnt/ovl-lower81:/mnt/ovl-lower82:/mnt/ovl-lower83:/mnt/ovl-lower84:/mnt/ovl-lower85:/mnt/ovl-lower86:/mnt/ovl-lower87:/mnt/ovl-lower88:/mnt/ovl-lower89:/mnt/ovl-lower90:/mnt/ovl-lower91:/mnt/ovl-lower92:/mnt/ovl-lower93:/mnt/ovl-lower94:/mnt/ovl-lower95:/mnt/ovl-lower96:/mnt/ovl-lower97:/mnt/ovl-lower98:/mnt/ovl-lower99:/mnt/ovl-lower100:/mnt/ovl-lower101:/mnt/ovl-lower102:/mnt/ovl-lower103:/mnt/ovl-lower104:/mnt/ovl-lower105:/mnt/ovl-lower106:/mnt/ovl-lower107:/mnt/ovl-lower108:/mnt/ovl-lower109:/mnt/ovl-lower110:/mnt/ovl-lower111:/mnt/ovl-lower112:/mnt/ovl-low
 er113:/mnt/ovl-lower114:/mnt/ovl-lower115:/mnt/ovl-lower116:/mnt/ovl-lower117:/mnt/ovl-lower118:/mnt/ovl-lower119:/mnt/ovl-lower120:/mnt/ovl-lower121:/mnt/ovl-lower122:/mnt/ovl-lower123:/mnt/ovl-lower124:/mnt/ovl-lower125:/mnt/ovl-lower126:/mnt/ovl-lower127:/mnt/ovl-lower128:/mnt/ovl-lower129:/mnt/ovl-lower130:/mnt/ovl-lower131:/mnt/ovl-lower132:/mnt/ovl-lower133:/mnt/ovl-lower134:/mnt/ovl-lower135:/mnt/ovl-lower136:/mnt/ovl-lower137:/mnt/ovl-lower138:/mnt/ovl-lower139:/mnt/ovl-lower140:/mnt/ovl-lower141:/mnt/ovl-lower142:/mnt/ovl-lower143:/mnt/ovl-lower144:/mnt/ovl-lower145:/mnt/ovl-lower146:/mnt/ovl-lower147:/mnt/ovl-lower148:/mnt/ovl-lower149:/mnt/ovl-lower150:/mnt/ovl-lower151:/mnt/ovl-lower152:/mnt/ovl-lower153:/mnt/ovl-lower154:/mnt/ovl-lower155:/mnt/ovl-lower156:/mnt/ovl-lower157:/mnt/ovl-lower158:/mnt/ovl-lower159:/mnt/ovl-lower160:/mnt/ovl-lower161:/mnt/ovl-lower162:/mnt/ovl-lower163:/mnt/ovl-lower164:/mnt/ovl-lower165:/mnt/ovl-lower166:/mnt/ovl-lower167:/mnt/ovl-lower168:/
 mnt/ovl-lower169:/mnt/ovl-lower170:/mnt/ovl-lower171:/mnt/ovl-lower172:/mnt/ovl-lower173:/mnt/ovl-lower174:/mnt/ovl-lower175:/mnt/ovl-lower176:/mnt/ovl-lower177:/mnt/ovl-lower178:/mnt/ovl-lower179:/mnt/ovl-lower180:/mnt/ovl-lower181:/mnt/ovl-lower182:/mnt/ovl-lower183:/mnt/ovl-lower184:/mnt/ovl-lower185:/mnt/ovl-lower186:/mnt/ovl-lower187:/mnt/ovl-lower188:/mnt/ovl-lower189:/mnt/ovl-lower190:/mnt/ovl-lower191:/mnt/ovl-lower192:/mnt/ovl-lower193:/mnt/ovl-lower194:/mnt/ovl-lower195:/mnt/ovl-lower196:/mnt/ovl-lower197:/mnt/ovl-lower198:/mnt/ovl-lower199:/mnt/ovl-lower200:/mnt/ovl-lower201:/mnt/ovl-lower202:/mnt/ovl-lower203:/mnt/ovl-lower204:/mnt/ovl-lower205:/mnt/ovl-lower206:/mnt/ovl-lower207:/mnt/ovl-lower208:/mnt/ovl-lower209:/mnt/ovl-lower210:/mnt/ovl-lower211:/mnt/ovl-lower212:/mnt/ovl-lower213:/mnt/ovl-lower214:/mnt/ovl-lower215:/mnt/ovl-lower216:/mnt/ovl-lower217:/mnt/ovl-lower218:/mnt/ovl-lower219:/mnt/ovl-lower220:/mnt/ovl-lower221:/mnt/ovl-lower222:/mnt/ovl-lower223:/mnt/ovl
 -lower224:/mnt/ovl-lower225:/mnt/ovl-lower226:/mnt/ovl-lower227:/mnt/ovl-lower228:/mnt/ovl-lower229:/mnt/ovl-lower230:/mnt/ovl-lower231:/mnt/ovl-lower232:/mnt/ovl-lower233:/mnt/ovl-lower234:/mnt/ovl-lower235:/mnt/ovl-lower236:/mnt/ovl-lower237:/mnt/ovl-lower238:/mnt/ovl-lower239:/mnt/ovl-lower240:/mnt/ovl-lower241:/mnt/ovl-lower242:/mnt/ovl-lower243:/mnt/ovl-lower244:/mnt/ovl-lower245:/mnt/ovl-lower246:/mnt/ovl-lower247:/mnt/ovl-lower248:/mnt/ovl-lower249:/mnt/ovl-lower250:/mnt/ovl-lower251:/mnt/ovl-lower252:/mnt/ovl-lower253:/mnt/ovl-lower254:/mnt/ovl-lower255:/mnt/ovl-lower256:/mnt/ovl-lower257:/mnt/ovl-lower258:/mnt/ovl-lower259:/mnt/ovl-lower260:/mnt/ovl-lower261:/mnt/ovl-lower262:/mnt/ovl-lower263:/mnt/ovl-lower264:/mnt/ovl-lower265:/mnt/ovl-lower266:/mnt/ovl-lower267:/mnt/ovl-lower268:/mnt/ovl-lower269:/mnt/ovl-lower270:/mnt/ovl-lower271:/mnt/ovl-lower272:/mnt/ovl-lower273:/mnt/ovl-lower274:/mnt/ovl-lower275:/mnt/ovl-lower276:/mnt/ovl-lower277:/mnt/ovl-lower278:/mnt/ovl-lower2
 79:/mnt/ovl-lower280:/mnt/ovl-lower281:/mnt/ovl-lower282:/mnt/ovl-lower283:/mnt/ovl-lower284:/mnt/ovl-lower285:/mnt/ovl-lower286:/mnt/ovl-lower287:/mnt/ovl-lower288:/mnt/ovl-lower289:/mnt/ovl-lower290:/mnt/ovl-lower291:/mnt/ovl-lower292:/mnt/ovl-lower293:/mnt/ovl-lower294:/mnt/ovl-lower295:/mnt/ovl-lower296:/mnt/ovl-lower297:/mnt/ovl-lower298:/mnt/ovl-lower299:/mnt/ovl-lower300:/mnt/ovl-lower301:/mnt/ovl-lower302:/mnt/ovl-lower303:/mnt/ovl-lower304:/mnt/ovl-lower305:/mnt/ovl-lower306:/mnt/ovl-lower307:/mnt/ovl-lower308:/mnt/ovl-lower309:/mnt/ovl-lower310:/mnt/ovl-lower311:/mnt/ovl-lower312:/mnt/ovl-lower313:/mnt/ovl-lower314:/mnt/ovl-lower315:/mnt/ovl-lower316:/mnt/ovl-lower317:/mnt/ovl-lower318:/mnt/ovl-lower319:/mnt/ovl-lower320:/mnt/ovl-lower321:/mnt/ovl-lower322:/mnt/ovl-lower323:/mnt/ovl-lower324:/mnt/ovl-lower325:/mnt/ovl-lower326:/mnt/ovl-lower327:/mnt/ovl-lower328:/mnt/ovl-lower329:/mnt/ovl-lower330:/mnt/ovl-lower331:/mnt/ovl-lower332:/mnt/ovl-lower333:/mnt/ovl-lower334:/mnt
 /ovl-lower335:/mnt/ovl-lower336:/mnt/ovl-lower337:/mnt/ovl-lower338:/mnt/ovl-lower339:/mnt/ovl-lower340:/mnt/ovl-lower341:/mnt/ovl-lower342:/mnt/ovl-lower343:/mnt/ovl-lower344:/mnt/ovl-lower345:/mnt/ovl-lower346:/mnt/ovl-lower347:/mnt/ovl-lower348:/mnt/ovl-lower349:/mnt/ovl-lower350:/mnt/ovl-lower351:/mnt/ovl-lower352:/mnt/ovl-lower353:/mnt/ovl-lower354:/mnt/ovl-lower355:/mnt/ovl-lower356:/mnt/ovl-lower357:/mnt/ovl-lower358:/mnt/ovl-lower359:/mnt/ovl-lower360:/mnt/ovl-lower361:/mnt/ovl-lower362:/mnt/ovl-lower363:/mnt/ovl-lower364:/mnt/ovl-lower365:/mnt/ovl-lower366:/mnt/ovl-lower367:/mnt/ovl-lower368:/mnt/ovl-lower369:/mnt/ovl-lower370:/mnt/ovl-lower371:/mnt/ovl-lower372:/mnt/ovl-lower373:/mnt/ovl-lower374:/mnt/ovl-lower375:/mnt/ovl-lower376:/mnt/ovl-lower377:/mnt/ovl-lower378:/mnt/ovl-lower379:/mnt/ovl-lower380:/mnt/ovl-lower381:/mnt/ovl-lower382:/mnt/ovl-lower383:/mnt/ovl-lower384:/mnt/ovl-lower385:/mnt/ovl-lower386:/mnt/ovl-lower387:/mnt/ovl-lower388:/mnt/ovl-lower389:/mnt/ovl-lo
 wer390:/mnt/ovl-lower391:/mnt/ovl-lower392:/mnt/ovl-lower393:/mnt/ovl-lower394:/mnt/ovl-lower395:/mnt/ovl-lower396:/mnt/ovl-lower397:/mnt/ovl-lower398:/mnt/ovl-lower399:/mnt/ovl-lower400:/mnt/ovl-lower401:/mnt/ovl-lower402:/mnt/ovl-lower403:/mnt/ovl-lower404:/mnt/ovl-lower405:/mnt/ovl-lower406:/mnt/ovl-lower407:/mnt/ovl-lower408:/mnt/ovl-lower409:/mnt/ovl-lower410:/mnt/ovl-lower411:/mnt/ovl-lower412:/mnt/ovl-lower413:/mnt/ovl-lower414:/mnt/ovl-lower415:/mnt/ovl-lower416:/mnt/ovl-lower417:/mnt/ovl-lower418:/mnt/ovl-lower419:/mnt/ovl-lower420:/mnt/ovl-lower421:/mnt/ovl-lower422:/mnt/ovl-lower423:/mnt/ovl-lower424:/mnt/ovl-lower425:/mnt/ovl-lower426:/mnt/ovl-lower427:/mnt/ovl-lower428:/mnt/ovl-lower429:/mnt/ovl-lower430:/mnt/ovl-lower431:/mnt/ovl-lower432:/mnt/ovl-lower433:/mnt/ovl-lower434:/mnt/ovl-lower435:/mnt/ovl-lower436:/mnt/ovl-lower437:/mnt/ovl-lower438:/mnt/ovl-lower439:/mnt/ovl-lower440:/mnt/ovl-lower441:/mnt/ovl-lower442:/mnt/ovl-lower443:/mnt/ovl-lower444:/mnt/ovl-lower445:
 /mnt/ovl-lower446:/mnt/ovl-lower447:/mnt/ovl-lower448:/mnt/ovl-lower449:/mnt/ovl-lower450:/mnt/ovl-lower451:/mnt/ovl-lower452:/mnt/ovl-lower453:/mnt/ovl-lower454:/mnt/ovl-lower455:/mnt/ovl-lower456:/mnt/ovl-lower457:/mnt/ovl-lower458:/mnt/ovl-lower459:/mnt/ovl-lower460:/mnt/ovl-lower461:/mnt/ovl-lower462:/mnt/ovl-lower463:/mnt/ovl-lower464:/mnt/ovl-lower465:/mnt/ovl-lower466:/mnt/ovl-lower467:/mnt/ovl-lower468:/mnt/ovl-lower469:/mnt/ovl-lower470:/mnt/ovl-lower471:/mnt/ovl-lower472:/mnt/ovl-lower473:/mnt/ovl-lower474:/mnt/ovl-lower475:/mnt/ovl-lower476:/mnt/ovl-lower477:/mnt/ovl-lower478:/mnt/ovl-lower479:/mnt/ovl-lower480:/mnt/ovl-lower481:/mnt/ovl-lower482:/mnt/ovl-lower483:/mnt/ovl-lower484:/mnt/ovl-lower485:/mnt/ovl-lower486:/mnt/ovl-lower487:/mnt/ovl-lower488:/mnt/ovl-lower489:/mnt/ovl-lower490:/mnt/ovl-lower491:/mnt/ovl-lower492:/mnt/ovl-lower493:/mnt/ovl-lower494:/mnt/ovl-lower495:/mnt/ovl-lower496::/mnt/ovl-lower497::/mnt/ovl-lower498::/mnt/ovl-lower499::/mnt/ovl-lower500,upp
 erdir=/mnt/ovl-upper,workdir=/mnt/ovl-work,redirect_dir=on,index=on,metacopy=on

Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Fix potential NULL deref in ovl_init_fs_context().
- Don't create one long mount option string for lowerdir. Just use
  seq_printf() to create it on demand.
- Link to v2: https://lore.kernel.org/r/20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org

Changes in v2:
- Split into two patches. First patch ports to new mount api without changing
  layer parsing. Second patch implements new layer parsing.
- Move layer parsing into a separate file.
- Link to v1: https://lore.kernel.org/r/20230605-fs-overlayfs-mount_api-v1-1-a8d78c3fbeaf@kernel.org

---



---
base-commit: f777c8266c1230fa44de7261b61a13d787b27f44
change-id: 20230605-fs-overlayfs-mount_api-20ea8b04eff4

