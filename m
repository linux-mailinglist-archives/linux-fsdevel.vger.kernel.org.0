Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30355708CDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 02:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjESA1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 20:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjESA1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 20:27:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED475199D;
        Thu, 18 May 2023 17:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ay4W8bozgbMDHggFbHb1tEFZ6uEkx4PpIr80gFSYx6c=; b=kNw0UCSRwPiIvPybr3/z9ZRngc
        /kaGi5Sf4+JVDVWKzNRglnirLN+Rj1zUZ0qxOqKuiyCU+MyNDwZ9suBLPpO90d0COwAf8rvNWNPBk
        3AMOcJvKBp3RPkfe0DngjxekZzLP+CSQyZKV19DlcZFpwADjAbnGBpkULnmlBetbCgJeA1pAGUBNU
        2EZ68P8a6sPiO18L201fXNp3K+u0pdPVJmNABt75fAcnAra3y9f/kXIeP71BbQRDH7f6p4eyx8fqU
        LEuwpB2GiVIYDQhrImSkUTFpoH4J5FDKcqjUR2nwN2vstjfwqTX+sAmd0w7myzt7srqRiz6d857uZ
        2tlX4ROA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pznx4-00EZ12-2B;
        Fri, 19 May 2023 00:26:34 +0000
Date:   Thu, 18 May 2023 17:26:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] sysctl: Remove register_sysctl_table from sources
Message-ID: <ZGbCOjS1n6zV9ZGV@bombadil.infradead.org>
References: <CGME20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc@eucas1p1.samsung.com>
 <20230518160705.3888592-1-j.granados@samsung.com>
 <ZGaOtM0TqmwOkdd6@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGaOtM0TqmwOkdd6@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 01:46:44PM -0700, Luis Chamberlain wrote:
> On Thu, May 18, 2023 at 06:07:03PM +0200, Joel Granados wrote:
> > This is part of the general push to deprecate register_sysctl_paths and
> > register_sysctl_table. This patchset completely removes register_sysctl_table
> > and replaces it with register_sysctl effectively transitioning 5 base paths
> > ("kernel", "vm", "fs", "dev" and "debug") to the new call. Besides removing the
> > actuall function, I also removed it from the checks done in check-sysctl-docs.
> > 
> > Testing for this change was done in the same way as with previous sysctl
> > replacement patches: I made sure that the result of `find /proc/sys/ | sha1sum`
> > was the same before and after the patchset.
> > 
> > Have pushed this through 0-day. Waiting on results..
> > 
> > Feedback greatly appreciated.
> 
> Thanks so much! I merged this to sysctl-testing as build tests are ongoing. But
> I incorporated these minor changes to your first patch as register_sysctl_init()
> is more obvious about when we cannot care about the return value.
> 
> If the build tests come through I'll push to sysctl-next.
> 

I also had to apply this (yay more nuking):

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7bc7d3c3a215..8873812d22f3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1466,19 +1466,6 @@ void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 	kmemleak_not_leak(hdr);
 }
 
-static char *append_path(const char *path, char *pos, const char *name)
-{
-	int namelen;
-	namelen = strlen(name);
-	if (((pos - path) + namelen + 2) >= PATH_MAX)
-		return NULL;
-	memcpy(pos, name, namelen);
-	pos[namelen] = '/';
-	pos[namelen + 1] = '\0';
-	pos += namelen + 1;
-	return pos;
-}
-
 static int count_subheaders(struct ctl_table *table)
 {
 	int has_files = 0;
@@ -1498,82 +1485,6 @@ static int count_subheaders(struct ctl_table *table)
 	return nr_subheaders + has_files;
 }
 
-static int register_leaf_sysctl_tables(const char *path, char *pos,
-	struct ctl_table_header ***subheader, struct ctl_table_set *set,
-	struct ctl_table *table)
-{
-	struct ctl_table *ctl_table_arg = NULL;
-	struct ctl_table *entry, *files;
-	int nr_files = 0;
-	int nr_dirs = 0;
-	int err = -ENOMEM;
-
-	list_for_each_table_entry(entry, table) {
-		if (entry->child)
-			nr_dirs++;
-		else
-			nr_files++;
-	}
-
-	files = table;
-	/* If there are mixed files and directories we need a new table */
-	if (nr_dirs && nr_files) {
-		struct ctl_table *new;
-		files = kcalloc(nr_files + 1, sizeof(struct ctl_table),
-				GFP_KERNEL);
-		if (!files)
-			goto out;
-
-		ctl_table_arg = files;
-		new = files;
-
-		list_for_each_table_entry(entry, table) {
-			if (entry->child)
-				continue;
-			*new = *entry;
-			new++;
-		}
-	}
-
-	/* Register everything except a directory full of subdirectories */
-	if (nr_files || !nr_dirs) {
-		struct ctl_table_header *header;
-		header = __register_sysctl_table(set, path, files);
-		if (!header) {
-			kfree(ctl_table_arg);
-			goto out;
-		}
-
-		/* Remember if we need to free the file table */
-		header->ctl_table_arg = ctl_table_arg;
-		**subheader = header;
-		(*subheader)++;
-	}
-
-	/* Recurse into the subdirectories. */
-	list_for_each_table_entry(entry, table) {
-		char *child_pos;
-
-		if (!entry->child)
-			continue;
-
-		err = -ENAMETOOLONG;
-		child_pos = append_path(path, pos, entry->procname);
-		if (!child_pos)
-			goto out;
-
-		err = register_leaf_sysctl_tables(path, child_pos, subheader,
-						  set, entry->child);
-		pos[0] = '\0';
-		if (err)
-			goto out;
-	}
-	err = 0;
-out:
-	/* On failure our caller will unregister all registered subheaders */
-	return err;
-}
-
 static void put_links(struct ctl_table_header *header)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
