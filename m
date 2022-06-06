Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7C53F22D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 00:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiFFWnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 18:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiFFWnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:43:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848138BB;
        Mon,  6 Jun 2022 15:43:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q7so21674002wrg.5;
        Mon, 06 Jun 2022 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skRII6n1qROdIomrVDtuJLM12M/rZ3f60pgprkoTeUA=;
        b=PA7jws9JDer7JUaDQVhV+Zqi+8EHO0JrYsSJblS8wYfoVNAypqyr2bhr4DgfleDAEc
         LZIz2NgB+NmsiTGTvjMaaAoBDlfoHKAeo2FoKzjbe+JnM74UE74x6AkjpSTT7aawD3D+
         3FbbG85HhnzgdQHWKpp6eEFMm6eaws6p6MzL0G+ke6r0WH3+WOlBzi4lIg79r454Qxbk
         8ybgG6E9h2F5wgwGs/ScfTLHAOIajTlzpSDiMQ1sUkRWkel5W2Gmsowa3mXXMdGrKqUl
         Q+7f/2k9VZlUUKMopH5pfYUfxpQ733kL9E+jk3Wv4n+IaarRhRosy/fVE5MBxi9MdtVl
         6Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skRII6n1qROdIomrVDtuJLM12M/rZ3f60pgprkoTeUA=;
        b=EC+sO2YNsIC1RRD8lJgDwaT/T1NqukMdZDixRShkSzjUV39zip5vDmUMP8RH5r0Y7G
         f13Zhv7Z7f/nh9yyG+XQSXNTqLYcozeTOJbMgdNYlqjYUQjyd7Ql549D5MJO8vNgC6we
         lEMDlJPlEDJUZxQ1WGROa9Jl9b9FKbAN+OW+14aoKCcXL+KJw6dhzeWsaLSesZ5iFF4E
         fFqRJQ3sirbPg4ljKFVBUbFrMnFseD8B9nG7cennqz19Mp3OJPYgqtUup70UwIlnDIuM
         b64HZSgSvY5ggiL8cOnvkDoqIECsjX5yOAuPT3IF0LkTBeD6dtkah6pJi+FZMmFsz9Ds
         kXNg==
X-Gm-Message-State: AOAM530wzfsNRZByQOYjwPoxAGgPMfWla5zXmbxBNZ3Jdnk2nZz/dtoS
        5zVQ9TAf8tRx35gypfmY4ey5pBm44RBQwERJ
X-Google-Smtp-Source: ABdhPJwP3KdCNuVRuhDIXhGJyk63byUOtaqq7UEcDzYRBUm80ntaXVKjLnn9E3IC1LGqy9HfiwCQHQ==
X-Received: by 2002:adf:e0c5:0:b0:206:1ba3:26aa with SMTP id m5-20020adfe0c5000000b002061ba326aamr24441247wri.645.1654555384645;
        Mon, 06 Jun 2022 15:43:04 -0700 (PDT)
Received: from DESKTOP-URN0IMF.localdomain (cpc78047-stav21-2-0-cust145.17-3.cable.virginm.net. [80.195.223.146])
        by smtp.gmail.com with ESMTPSA id l14-20020adfe58e000000b002117ef160fbsm16060582wrm.21.2022.06.06.15.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 15:43:04 -0700 (PDT)
From:   Oliver Ford <ojford@gmail.com>
To:     linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com
Cc:     linux-kernel@vger.kernel.org, ojford@gmail.com
Subject: [PATCH 0/1] fs: inotify: Add full paths option to inotify
Date:   Mon,  6 Jun 2022 23:42:40 +0100
Message-Id: <20220606224241.25254-1-ojford@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds an option to return the full path in inotify events. Currently, user space has to keep track of watch descriptors and paths, mapping the descriptor returned when reading inotify events to the path. Adding an option to return the full path simplifies user space code.

The patch adds a flag, IN_FULL_PATHS, to the available mask in inotify_add_watch. When set, the full path is returned when events are added to the watch queue and a path is available. For the event IN_MOVE_SELF, a check is performed that the user has access to the new path. This prevents exposing the names of directories if, for example, root moves "/home/dmr/watched" to "/root/top_secret/watched". In that case, the watch is removed and a Permission Denied error is returned. For the IN_DELETE_SELF/IN_IGNORED pair, no path is returned.

Oliver Ford (1):
  fs: inotify: Add full paths option to inotify

 fs/notify/inotify/inotify_fsnotify.c | 55 ++++++++++++++++++++++------
 fs/notify/inotify/inotify_user.c     | 19 +++++++++-
 include/linux/inotify.h              |  2 +-
 include/uapi/linux/inotify.h         |  1 +
 4 files changed, 63 insertions(+), 14 deletions(-)

-- 
2.35.1

