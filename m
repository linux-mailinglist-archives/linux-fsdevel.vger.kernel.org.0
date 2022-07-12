Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E2571A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiGLMfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 08:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiGLMf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A815F2CE3A
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657629325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZRNqvwEkQjWUz9SudAZmar3Unjg5boMD/ciY51IuWI8=;
        b=SEeeuV8wim7wWiNWiHG98g757EVKnVALewc6PYZhuU4rj2z6W4GZ1myeMphAuHBF+ERxga
        tDJPPyalHE7N6VTdlmLNdC3+o2gTjJ3rmluiPJ2QOp24lWTpt5ItF7QQWIfquTn7D+oyqJ
        2aZ83O4KqtYoAOvOmHBUq37bkyFAgAc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-Fr7dWCPbPbS7hKwO1fVVSw-1; Tue, 12 Jul 2022 08:35:22 -0400
X-MC-Unique: Fr7dWCPbPbS7hKwO1fVVSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FAF02919EBB;
        Tue, 12 Jul 2022 12:35:22 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDAE82026D64;
        Tue, 12 Jul 2022 12:35:21 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 50C4A10C30E0; Tue, 12 Jul 2022 08:35:21 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, Ian Kent <raven@themaw.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/2] Keyagents: another call_usermodehelper approach for namespaces
Date:   Tue, 12 Jul 2022 08:35:19 -0400
Message-Id: <cover.1657624639.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A persistent unsolved problem exists: how can the kernel find and/or create
the appropriate "container" within which to execute a userspace program to
construct keys or satisfy users of call_usermodehelper()?

I believe the latest serious attempt to solve this problem was David's "Make
containers kernel objects":
https://lore.kernel.org/lkml/149547014649.10599.12025037906646164347.stgit@warthog.procyon.org.uk/

Over in NFS' space, we've most recently pondered this issue while looking at
ways to pass a kernel socket to userspace in order to handle TLS events:
https://lore.kernel.org/linux-nfs/E2BF9CFF-9361-400B-BDEE-CF5E0AFDCA63@redhat.com/

The problem is that containers are not kernel objects, rather a collection
of namespaces, cgroups, etc.  Attempts at making the kernel aware of
containers have been mired in discussion and problems.  It has been
suggested that the best representation of a "container" from the kernel's
perspective is a process.

Keyagents are processes represented by a key.  If a keyagent's key is linked
to a session_keyring, it can be sent a realtime signal when a calling
process requests a matching key_type.  That signal will dispatch the process
to construct the desired key within the keyagent process context.  Keyagents
are similar to ssh-agents.  To use a keyagent, one must execute a keyagent
process in the desired context, and then link the keyagent's key onto other
process' session_keyrings.

This method of linking keyagent keys to session_keyrings can be used to
construct the various mappings of callers to keyagents that containers may
need.  A single keyagent process can answer request-key upcalls across
container boundaries, or upcalls can be restricted to specific containers.

I'm aware that building on realtime signals may not be a popular choice, but
using realtime signals makes this work simple and ensures delivery.  Realtime
signals are able to convey everything needed to construct keys in userspace:
the under-construction key's serial number.

This work is not complete; it has security implications, it needs
documentation, it has not been reviewed by anyone.  Thanks for reading this
RFC.  I wish to collect criticism and validate this approach.

Below the diffstat in this message is an example userspace program to answer
keyagent requests for user keys. It can be compiled with:
gcc -lkeyutils -o ka_simple ka_simple.c

Benjamin Coddington (2):
  KEYS: Add key_type keyagent
  KEYS: Add keyagent request_key

 include/uapi/asm-generic/siginfo.h |   1 +
 security/keys/Kconfig              |   9 ++
 security/keys/Makefile             |   1 +
 security/keys/internal.h           |   4 +
 security/keys/keyagent.c           | 158 +++++++++++++++++++++++++++++
 security/keys/request_key.c        |   9 ++
 6 files changed, 182 insertions(+)
 create mode 100644 security/keys/keyagent.c

-- 
// SPDX-License-Identifier: GPL-2.0-only
/* ka_simple.c: userspace keyagent example
 *
 * Copyright (C) 2022 Red Hat Inc. All Rights Reserved.
 * Written by Benjamin Coddington (bcodding@redhat.com)
 *
 * This programs registers a simple keyagent for user keys that will handle
 * requests from the kernel keyagent, and instantiate keys that have
 * callout_info == "test_callout_info".
 */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <err.h>
#include <errno.h>
#include <stdlib.h>
#include <signal.h>
#include <linux/types.h>
#include <keyutils.h>
#include <sys/signalfd.h>

int ka_sig_fd = 0;
key_serial_t ka_key_serial;
__be16 ka_signal;

/* Setup a signalfd masked to SIGRTMIN + 1 */
void ka_sig_setup()
{
	int ret;
	sigset_t mask;

	/* Which realtime signal are we using? */
	ka_signal = SIGRTMIN + 1;

	sigemptyset(&mask);
	sigaddset(&mask, ka_signal);

	ret = sigprocmask(SIG_BLOCK, &mask, NULL);
	if (ret != 0)
		err(ret, "rt_sigprocmask");

	ka_sig_fd = signalfd(-1, &mask, 0);
	if (ka_sig_fd == -1)
		err(ret, "signalfd");
}

/* Register this process as a keyagent for user keys to be notified by
 * signal number SIGRTMIN + 1 by creating a keyagent key with a description
 * of "user", and payload of SIGRTMIN + 1 */
void ka_register()
{
	printf("Registering as keyagent for user keys with signal %d\n", ka_signal);
	/* The kernel will place authorization keys on our process keyring.
	 * Make sure we have a process keyring: */
	keyctl_get_keyring_ID(KEY_SPEC_PROCESS_KEYRING, 1);
	ka_key_serial = add_key("keyagent", "user", &ka_signal, sizeof(unsigned int), KEY_SPEC_SESSION_KEYRING);

	if (ka_key_serial == -1)
		err(errno, "add_key");

	/* Permissions for the keyagent's key: */
	keyctl_setperm(ka_key_serial, KEY_USR_ALL);
}

/* Handle kernel request_key().  The serial number of the key is the int
 * passed in the realtime signal */
int ka_request_key(key_serial_t key) {
	int ret, ntype, dpos, n;
	char *buf_type_desc, *key_type, *key_desc;
	void *callout;

	printf("ka_request_key %d\n", key);

	ret = keyctl_assume_authority(key);
	if (ret < 0) {
		warn("failed to assume authority over key %d (%m)\n", key);
		goto out;
	}

	ret = keyctl_describe_alloc(key, &buf_type_desc);
	if (ret < 0) {
		warn("key %d inaccessible (%m)\n", key);
		goto out;
	}

	printf("Key descriptor: \"%s\"\n", buf_type_desc);

	/* Shamelessly copied from libkeyutils/request_key.c: */
	ntype = -1;
	dpos = -1;

	n = sscanf(buf_type_desc, "%*[^;]%n;%*d;%*d;%x;%n", &ntype, &n, &dpos);
	if (n != 1)
		printf("Failed to parse key description\n");

	key_type = buf_type_desc;
	key_type[ntype] = 0;
	key_desc = buf_type_desc + dpos;

	ret = keyctl_read_alloc(KEY_SPEC_REQKEY_AUTH_KEY, &callout);
	if (ret < 0) {
		warn("failed to retrieve callout info (%m)\n");
		goto out_free_type;
	}

	if (strcmp(buf_type_desc, "user") == 0 && strcmp(callout, "test_callout_info") == 0) {
		keyctl_instantiate(key, "keyagent_payload", sizeof("keyagent_payload"), KEY_SPEC_SESSION_KEYRING);
		printf("instantiated key %d with payload \"keyagent_payload\" on session keyring\n", key);
	} else {
		keyctl_reject(key, 10, EKEYREJECTED, KEY_SPEC_SESSION_KEYRING);
		printf("this keyagent only instantiates user keys with callout \"test_callout_info\"\n");
	}

	/* De-assume the authority (for now) */	
	ret = keyctl_assume_authority(0);
	free(callout);
	
out_free_type:
	free(buf_type_desc);
out:
	return ret;
}

/* Handle signals from our signalfd, dispatch ka_request_key() */
int ka_process()
{
	struct signalfd_siginfo fdsi;
	ssize_t size;

	for (;;) {
		size = read(ka_sig_fd, &fdsi, sizeof(struct signalfd_siginfo));
		if (size != sizeof(struct signalfd_siginfo))
			err(EINVAL, "reading signal_fd");

		if (ka_request_key(fdsi.ssi_int))
			break;
	}
}

int main(int argc, char **argv)
{
	ka_sig_setup();
	ka_register();

	printf("Registered as keyagent with key %d\n", ka_key_serial);
	printf("Subscribe to this keyagent by linking it into your session keyring with:\n\tkeyctl link %d @s\n", ka_key_serial);
	printf("then, you can send a request to this agent with:\n\tkeyctl request2 user <description> \"test_callout_info\"\n");

	ka_process();
}

--
2.31.1

